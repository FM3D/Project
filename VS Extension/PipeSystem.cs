﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Diagnostics;
using System.IO.Pipes;
using System.Windows.Forms;
using System.IO;
using Microsoft.VisualStudio.VCCodeModel;
using FM3D_Designer.src;

namespace VS_Extension
{
    public static class PipeSystem
    {
        #region Pipe stuff
        private const string COMMAND = "Command: ";

        private static NamedPipeClientStream pipe;
        private static byte[] readBuffer = new byte[4096];
        private static Thread thread;

        private static StreamWriter writer;
        private static StreamReader reader;

        private static Mutex actionMutex = new Mutex();
        private static Mutex readMutex = new Mutex();
        private static string readString;
        private static string ReadString
        {
            get
            {
                while (true)
                {
                    lock (actionMutex)
                    {
                        if (readString.Length > 0)
                        {
                            string local = readString;
                            readString = "";
                            return local;
                        }
                    }
                    Thread.Sleep(2);
                }
            }
        }

        public static bool Start(string pipename)
        {
            var current = Process.GetCurrentProcess();
            string id = current.Id.ToString();
            
            pipe = new NamedPipeClientStream(".", pipename, PipeDirection.InOut);
            try
            {
                pipe.Connect(1000);
            }
            catch (TimeoutException e)
            {
                MessageBox.Show("Connection to FM3D-Designer timed out\n" + e.Message + "\n\nTry to restart Visual Studio. Changes you make to the solution while not connected to the Designer can break your project!", "FM3D-Extension-Error");
                return false;
            }

            MessageBox.Show("Succesfully established a connection to the Designer!", "FM3D-Extension-Info");
            thread = new Thread(Communicate);
            thread.Start();
            return true;
        }

        private static void Communicate()
        {
            writer = new StreamWriter(pipe);
            writer.AutoFlush = true;
            reader = new StreamReader(pipe);

            while (pipe?.IsConnected == true)
            {
                string s = reader.ReadLine();
                if (s.StartsWith(COMMAND))
                {
                    lock (actionMutex)
                    {
                        switch (s.Substring(COMMAND.Length))
                        {
                            case "GetComponents":
                                SendComponents();
                                break;
                            case "AddClass":
                                AddClassPipe();
                                break;
                            case "Build":
                                Build();
                                break;
                            case "Start":
                                Start();
                                break;
                            case "CreateEntity":
                                CreateEntity();
                                break;
                            default:
                                MessageBox.Show("Received unreadable message from FM3D-Designer", "Connection failure");
                                break;
                        }
                    }
                }
                else
                {
                    lock (readMutex)
                    {
                        readString = s;
                    }
                }
            }
            writer.Close();
            reader.Close();
        }
        #endregion

        #region Reactions

        private static void Start()
        {
            bool debugging = Convert.ToBoolean(reader.ReadLine());
            if (debugging)
                MainPackage.Instance.dte.ExecuteCommand("Debug.Start");
            else
                MainPackage.Instance.dte.ExecuteCommand("Debug.StartWithoutDebugging");
        }
        
        private static void Build()
        {
            MainPackage.Instance.dte.ExecuteCommand("Build.BuildSolution");
        }

        private static void SendComponents()
        {
            CodeAnalyzer code = new CodeAnalyzer(MainPackage.Instance.MainProject);
            var strings = code.GetComponents();

            writer.WriteLine(strings.Count.ToString());

            foreach (string s in strings)
            {
                writer.WriteLine(s);
            }
        }

        private static void AddClassPipe()
        {
            string name = reader.ReadLine();
            string file = reader.ReadLine();

            CodeManipulator manipulator = null;
            try
            {
                manipulator = new CodeManipulator(file);
            }
            catch (ArgumentException e)
            {
                if (e.ParamName == "filename")
                {
                    writer.WriteLine("InvalidFile");
                    return;
                }
            }
            writer.WriteLine("ValidFile");
            int baseCount = Convert.ToInt32(reader.ReadLine());

            var bases = new string[baseCount];
            for (int i = 0; i < baseCount; i++)
            {
                bases[i] = reader.ReadLine();
            }
            //EnvDTE.CodeClass class_ = 
            manipulator.AddClass(name, bases);
        }

        #region Export Entities
        private static void CreateEntity() {
            CodeManipulator manipulator = new CodeManipulator("presets.h");
			string entstr = reader.ReadLine();
			Entity temp = new Entity(entstr);
            CreateBase(temp, new CodeManipulator("presets.h"));
            //manipulator.AddAttribute("Wuschel", "Blah3");
            MessageBox.Show("if you want to export a second time,\ndelete all Content in presets.h\n and include the FM3D-Engine with \n#include<Engine.h>","WARNING");
        }

        private static void CreateBase(Entity ent, CodeManipulator mani) {
			mani.AddNamespace("Entities");
            mani.AddClass("preset_" + ent.name, "Entities", "FM3D::EntitySystem::Preset");
			
			VCCodeFunction setcomp = mani.AddMethod(
						"Entities",
						"preset_" + ent.name,
						"SetComponents",
						EnvDTE.vsCMFunction.vsCMFunctionFunction,
						"void",
						EnvDTE.vsCMAccess.vsCMAccessPublic);
            if (setcomp!=null)
            {
                mani.AddAttribute(setcomp, "e", "FM3D::EntitySystem::EntityPtr");
            }
			

			string components="";
			foreach (Component comp in ent.components) {
				string properties = "";

				int counter = 0;
				
				foreach (Property prop in comp._propauto) {
					if (comp.m_standard) {

						if (comp._propauto.Count > 1) {
							if (counter < comp._propauto.Count) {
								properties += "m_" + prop.name + ","; counter++;
							} else {
								properties += "m_" + prop.name;
							}
						} else {
							properties += "m_" + prop.name;
						}
					}
					// erstellt das Attribut in der Klasse
					mani.AddVariable("preset_" + ent.name, "Entities", "m_" + prop.name, prop.type, null, EnvDTE.vsCMAccess.vsCMAccessPrivate, null);

					// erstellt Get Set Methoden
					if (prop.m_get) {

						VCCodeFunction qq = mani.AddMethod(
							"Entities",
							"preset_" + ent.name,
							"Get" + prop.name,
							EnvDTE.vsCMFunction.vsCMFunctionFunction,
							prop.type,
							EnvDTE.vsCMAccess.vsCMAccessPublic);
                        if (qq!=null)
                        {
                            mani.AddTextBodyOfMethod(qq, "return m_" + prop.name + ";");
                        }						
					}
					if (prop.m_set) {
						VCCodeFunction pp = mani.AddMethod(
							"Entities",
							"preset_" + ent.name,
							"Set" + prop.name,
							EnvDTE.vsCMFunction.vsCMFunctionFunction,
							"void",
							EnvDTE.vsCMAccess.vsCMAccessPublic);
                        if (pp!=null)
                        {
                            mani.AddAttribute(pp, "m_" + prop.name + "_", prop.type);
                            mani.AddTextBodyOfMethod(pp, "m_" + prop.name + "=" + "m_" + prop.name + "_;");
                        }
					}
				}
				if (comp.m_standard) {
					components += "e->Add<" + comp.name + ">(" + properties + "); \n";
				}
			}

			foreach (Property prop in ent._propcustom) {
				// erstellt das Attribut in der Klasse
				mani.AddVariable("preset_" + ent.name, "Entities", "m_" + prop.name, prop.type, null, EnvDTE.vsCMAccess.vsCMAccessPrivate, null);
				// erstellt Get Set Methoden
				if (prop.m_get) {

					VCCodeFunction qq = mani.AddMethod(
						"Entities",
						"preset_" + ent.name,
						"Get" + prop.name,
						EnvDTE.vsCMFunction.vsCMFunctionFunction,
						prop.type,
						EnvDTE.vsCMAccess.vsCMAccessPublic);
                    if (qq != null)
                    {
                        mani.AddTextBodyOfMethod(qq, "return m_" + prop.name + ";");
                    }
				}
				if (prop.m_set) {
					VCCodeFunction pp = mani.AddMethod(
						"Entities",
						"preset_" + ent.name,
						"Set" + prop.name,
						EnvDTE.vsCMFunction.vsCMFunctionFunction,
						"void",
						EnvDTE.vsCMAccess.vsCMAccessPublic);
                    if (pp!=null)
                    {
                        mani.AddAttribute(pp, "m_" + prop.name + "_", prop.type);
                        mani.AddTextBodyOfMethod(pp, "m_" + prop.name + "=" + "m_" + prop.name + "_;");
                    }
				}
			}
			mani.AddTextBodyOfMethod(setcomp, components);
		}
		#endregion

		#endregion
	}
}
