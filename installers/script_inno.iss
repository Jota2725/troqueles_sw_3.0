; Script de Inno Setup para instalación per-user (sin admin)

#define MyAppName "Troqueles SW"
#define MyAppVersion "2.0.0"
#define MyAppPublisher "Smurfit Westrock"
#define MyAppURL "https://www.smurfitwestrock.com/"
#define MyAppExeName "troqueles_sw.exe"

; --- Ajusta a tu build real ---
#define BuildOutput "C:\Users\julia\Desktop\Troqueles_sw\troqueles_sw\build\windows\x64\runner\Release"

; --- Ruta de tu DB semilla (opcional) ---
#define SeedDbPath "C:\Users\julia\Desktop\Troqueles_sw\troqueles_sw\data\troqueles.db"

[Setup]
AppId={{A8412CCC-B34C-4FB5-BC70-7DF6F5B91CA7}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}

PrivilegesRequired=lowest
DefaultDirName={localappdata}\{#MyAppName}
UsePreviousAppDir=yes
DisableDirPage=no
AllowRootDirectory=yes

AppMutex=TroquelesSWMutex
CloseApplications=yes
RestartApplications=no

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

[Dirs]
; Carpeta donde la app guardará la base
Name: "{app}\data"

[Files]
; Copia todo el build Release de Flutter (exe, dlls, data/, etc.)
Source: "{#BuildOutput}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

; (OPCIONAL) Copiar la DB semilla:
; - onlyifdoesntexist: no pisa una DB ya existente (upgrades seguros)
; - uninsneveruninstall: NO borrar la DB al desinstalar (no perder datos)
Source: "{#SeedDbPath}"; DestDir: "{app}\data"; DestName: "troqueles.db"; \
  Flags: onlyifdoesntexist ignoreversion uninsneveruninstall

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
    ConfigText :=
      'InstallDir=' + ExpandConstant('{app}') + #13#10 +
      'DbPath=' + ExpandConstant('{app}\data\troqueles.db');
    SaveStringToFile(ConfigFile, ConfigText, False);
  end;
end;
