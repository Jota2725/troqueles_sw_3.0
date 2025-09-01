; Script de Inno Setup para instalación per-user (sin admin)
; Asegúrate de compilar antes: flutter build windows --release

#define MyAppName "Troqueles SW"
#define MyAppVersion "2.0"
#define MyAppPublisher "Smurfit Westrock"
#define MyAppURL "https://www.smurfitwestrock.com/"
#define MyAppExeName "troqueles_sw.exe"

[Setup]
; Mantén este AppId fijo entre versiones para upgrades correctos
AppId={{A8412CCC-B34C-4FB5-BC70-7DF6F5B91CA7}}

AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}

; SIN ADMIN
PrivilegesRequired=lowest
; Instala por usuario en AppData local (sin UAC)
DefaultDirName={localappdata}\{#MyAppName}
; Guarda la carpeta elegida para upgrades
UsePreviousAppDir=yes
DisableDirPage=no
AllowRootDirectory=yes
CloseApplications=yes

ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible

OutputDir=C:\Users\julia\OneDrive\Escritorio\Troqueles_sw\troqueles_sw\installers
OutputBaseFilename=SetupTroqueles
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Copia TODO lo generado por Flutter en Release (incluye dlls, data/, icudtl.dat, plugins/)
Source: "C:\Users\julia\OneDrive\Escritorio\Troqueles_sw\troqueles_sw\build\windows\x64\runner\Release\*"; \
  DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; \
  Flags: nowait postinstall skipifsilent

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  ConfigFile: string;
  ConfigText: AnsiString;
begin
  if CurStep = ssPostInstall then
  begin
    ConfigFile := ExpandConstant('{app}\config.ini');
    ConfigText := 'InstallDir=' + ExpandConstant('{app}');
    SaveStringToFile(ConfigFile, ConfigText, False);
  end;
end;
