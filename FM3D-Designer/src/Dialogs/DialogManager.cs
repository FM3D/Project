﻿using MahApps.Metro.Controls;
using MahApps.Metro.Controls.Dialogs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FM3D_Designer.src.Dialogs
{

    public class DialogBase : BaseMetroDialog
    {
        public MetroWindow Window { get; private set; }
        protected DialogBase(MetroWindow win)
        {
            Window = win;
        }
    
        public DialogBase()
        {
            Window = MainWindow.Instance;
        }

        protected DialogBase(MetroWindow win, DialogBase parent)
        {
            Window = MainWindow.Instance;
        }

        public void Close()
        {
            Window.HideMetroDialogAsync(this);
        }

        public async void CloseW()
        {
            await Window.HideMetroDialogAsync(this);
        }
    }

    public static class DialogManager
    {
        public static void ShowNewResourceDialog(this MetroWindow window)
        {
            window.ShowMetroDialogAsync(new NewResourceDialog(window));
        }

        public static void ShowEntityEditor(this MetroWindow window, bool isnewentity, string path)
        {
            if(!MainWindow.Instance.visualStudio.IsStarted)
            {
                window.ShowMessageAsync("Connection Error", "Your Visual Studio (2015) is not started.\nPlease start it from the toolbar.");
                return;
            }
            window.ShowMetroDialogAsync(new EntityEditor(window, path, isnewentity ));
        }

        public static void ShowAddFileDialog(this MetroWindow window, string path)
        {
            window.ShowMetroDialogAsync(new AddFileDialog(window, path));
        }

        public async static void ShowModelDialog(this MetroWindow window, string path)
        {
            await window.ShowMetroDialogAsync(new ModelDialog(window, path));
        }

        public static void ShowChangeMeshDialog(this MetroWindow window, DesignerLib.ExternResource res, DesignerLib.FoundResource fres)
        {
            window.ShowMetroDialogAsync(new ChangeMeshDialog(window, res, fres));
        }

    }
}
