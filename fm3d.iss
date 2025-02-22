; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "FM3D-Engine"
#define MyAppVerName "FlyingMind3D Engine 1.0"
#define MyAppPublisher "FM3D-Team"
#define MyAppURL "http://github.com/fm3d/fm3d-engine"
#define MyAppExeName "FM3D-Designer.exe"

[Setup]
AppName={#MyAppName}
AppVerName={#MyAppVerName}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
ChangesAssociations=yes
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=no
LicenseFile=D:\fm3d-engine\InstallerInfo\license.txt
InfoBeforeFile=D:\fm3d-engine\InstallerInfo\before_install.txt
InfoAfterFile=D:\fm3d-engine\InstallerInfo\after_install.txt
OutputDir=D:\fm3d-engine
OutputBaseFilename=fm3d_setup
SetupIconFile=D:\fm3d-engine\FM3D-Designer\ICON.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

; Input here Le Files and Directories
[Files]
;Source: "D:\fm3d-engine\Designer Lib\*"; Excludes: "D:\fm3d-engine\Designer Lib\x64" ;  DestDir: {app}\Designer Lib;  Flags: recursesubdirs
;Source: "D:\fm3d-engine\FM3D-Designer\*";                                               DestDir: {app}\FM3D-Designer; Flags: recursesubdirs

;================
;||  License   ||
;================
Source: "D:\fm3d-engine\InstallerInfo\license.txt";                                     DestDir: {app}\README;        Flags: ignoreversion

;================
;||  Extension ||
;================
Source: "D:\fm3d-engine\VS Extension\bin\Debug\VS Extension.vsix";                      DestDir: {app}\Extension;     Flags: recursesubdirs

;================
;||  DESIGNER  ||
;================
Source: "D:\fm3d-engine\FM3D-Designer\bin\Debug\FreeImage.dll";                         DestDir: {app}\FM3D-Designer\bin\Debug; Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Designer\bin\Debug\Assimp32.dll";                          DestDir: {app}\FM3D-Designer\bin\Debug; Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Designer\bin\Debug\DesignerLib.dll";                       DestDir: {app}\FM3D-Designer\bin\Debug; Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Designer\bin\Debug\FM3D-Engine.dll";                       DestDir: {app}\FM3D-Designer\bin\Debug; Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Designer\bin\Debug\DevComponents.WPF.Controls.dll";        DestDir: {app}\FM3D-Designer\bin\Debug; Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Designer\bin\Debug\DevComponents.WpfDock.dll";             DestDir: {app}\FM3D-Designer\bin\Debug; Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Designer\bin\Debug\MahApps.Metro.dll";                     DestDir: {app}\FM3D-Designer\bin\Debug; Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Designer\bin\Debug\System.Windows.Interactivity.dll";      DestDir: {app}\FM3D-Designer\bin\Debug; Flags: recursesubdirs

Source: "D:\fm3d-engine\FM3D-Designer\DotNetBar\*";                                     DestDir: {app}\FM3D-Designer\DotNetBar; Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Designer\resources\*";                                     DestDir: {app}\FM3D-Designer\resources; Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Designer\TestProjects\*";                                  DestDir: {app}\FM3D-Designer\TestProjects; Flags: recursesubdirs

Source: "D:\fm3d-engine\FM3D-Designer\ICON.ico";                                       DestDir: {app}\FM3D-Designer; Flags: recursesubdirs

Source: "D:\fm3d-engine\FM3D-Designer\bin\Debug\FM3D-Designer.exe";                     DestDir: {app}\FM3D-Designer\bin\Debug; Flags: recursesubdirs



;================
;||  ENGINE    ||
;================

; Dependencies

Source: "D:\fm3d-engine\FM3D-Engine\Dependencies\*";                                    DestDir: {app}\FM3D-Engine\Dependencies;   Flags: recursesubdirs
Source: "D:\fm3d-engine\Debug\FM3D-Engine.dll";                                         DestDir: {app}\Debug;         Flags: ignoreversion
Source: "D:\fm3d-engine\Debug\FM3D-Engine.lib";                                         DestDir: {app}\Debug;         Flags: ignoreversion

;   HeaderFiles

; ==EntitySystem==
Source: "D:\fm3d-engine\FM3D-Engine\src\EntitySystem\Component.h";                      DestDir: {app}\FM3D-Engine\src\EntitySystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\EntitySystem\ComponentArgs.h";                  DestDir: {app}\FM3D-Engine\src\EntitySystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\EntitySystem\Entity.h";                         DestDir: {app}\FM3D-Engine\src\EntitySystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\EntitySystem\EntityCollection.h";               DestDir: {app}\FM3D-Engine\src\EntitySystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\EntitySystem\EntityLogic.h";                    DestDir: {app}\FM3D-Engine\src\EntitySystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\EntitySystem\Event.h";                          DestDir: {app}\FM3D-Engine\src\EntitySystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\EntitySystem\Group.h";                          DestDir: {app}\FM3D-Engine\src\EntitySystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\EntitySystem\Matcher.h";                        DestDir: {app}\FM3D-Engine\src\EntitySystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\EntitySystem\Preset.h";                         DestDir: {app}\FM3D-Engine\src\EntitySystem;   Flags: recursesubdirs

; ==FileSystem==
Source: "D:\fm3d-engine\FM3D-Engine\src\FileSystem\ExternFileManager.h";                DestDir: {app}\FM3D-Engine\src\FileSystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\FileSystem\FileManager.h";                      DestDir: {app}\FM3D-Engine\src\FileSystem;   Flags: recursesubdirs

; ==Graphics==
Source: "D:\fm3d-engine\FM3D-Engine\src\Graphics\*";                                    DestDir: {app}\FM3D-Engine\src\Graphics;   Flags: recursesubdirs

; ==Math==
Source: "D:\fm3d-engine\FM3D-Engine\src\Math\Math.h";                                   DestDir: {app}\FM3D-Engine\src\Math;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Math\Matrix.h";                                 DestDir: {app}\FM3D-Engine\src\Math;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Math\Matrix2.h";                                DestDir: {app}\FM3D-Engine\src\Math;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Math\Matrix4.h";                                DestDir: {app}\FM3D-Engine\src\Math;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Math\Quaternion.h";                             DestDir: {app}\FM3D-Engine\src\Math;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Math\Transformation.h";                         DestDir: {app}\FM3D-Engine\src\Math;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Math\Vector.h";                                 DestDir: {app}\FM3D-Engine\src\Math;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Math\Vector2.h";                                DestDir: {app}\FM3D-Engine\src\Math;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Math\Vector3.h";                                DestDir: {app}\FM3D-Engine\src\Math;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Math\Vector4.h";                                DestDir: {app}\FM3D-Engine\src\Math;   Flags: recursesubdirs

; ==Memory==
Source: "D:\fm3d-engine\FM3D-Engine\src\Memory\*";                                      DestDir: {app}\FM3D-Engine\src\Memory;   Flags: recursesubdirs

; ==Utilities==
Source: "D:\fm3d-engine\FM3D-Engine\src\Utilities\CompCoords.h";                        DestDir: {app}\FM3D-Engine\src\Utilities;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Utilities\StringUtilities.h";                   DestDir: {app}\FM3D-Engine\src\Utilities;   Flags: recursesubdirs

; ==Window==
Source: "D:\fm3d-engine\FM3D-Engine\src\WindowSystem\Input.h";                          DestDir: {app}\FM3D-Engine\src\WindowSystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\WindowSystem\Win32Window.h";                    DestDir: {app}\FM3D-Engine\src\WindowSystem;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\WindowSystem\Window.h";                         DestDir: {app}\FM3D-Engine\src\WindowSystem;   Flags: recursesubdirs

; ==src==
Source: "D:\fm3d-engine\FM3D-Engine\src\BasicComponents.h";                             DestDir: {app}\FM3D-Engine\src;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Entity.h";                                      DestDir: {app}\FM3D-Engine\src;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\EventSystem.h";                                 DestDir: {app}\FM3D-Engine\src;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Output.h";                                      DestDir: {app}\FM3D-Engine\src;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\pch.h";                                         DestDir: {app}\FM3D-Engine\src;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Test.h";                                        DestDir: {app}\FM3D-Engine\src;   Flags: recursesubdirs
Source: "D:\fm3d-engine\FM3D-Engine\src\Timer.h";                                       DestDir: {app}\FM3D-Engine\src;   Flags: recursesubdirs

; NOTE: Don't use "Flags: ignoreversion" on any shared system files
; D:\fm3d-engine\InstallerInfo

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\FM3D-Designer\bin\Debug\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\FM3D-Designer\bin\Debug\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\FM3D-Designer\bin\Debug\{#MyAppExeName}"; Description: "{cm:LaunchProgram, FM3D-Designer}"; Flags: nowait postinstall skipifsilent
Filename: "http://fm3d.github.io"; Description: "Launch Webpage"; Flags: nowait postinstall skipifsilent shellexec
;Filename: "{app}\Extension\VS Extension.vsix"; Description: "Install Extension for VisualStudio 2015";
Filename: "{cmd}"; Parameters:"/c ""{app}\Extension\VS Extension.vsix"""; Description: "Install Extension"; Flags: nowait postinstall skipifsilent shellexec


