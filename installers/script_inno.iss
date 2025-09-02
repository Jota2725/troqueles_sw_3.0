; ==== DEFINES ================================================================
#define MyAppName "Troqueles SW"
#define MyAppVersion "2.0.1"
#define MyAppPublisher "Smurfit Westrock"
#define MyAppURL "https://www.smurfitwestrock.com/"
#define MyAppExeName "troqueles_sw.exe"

; Ruta base del repo: carpeta que contiene este .iss
#define ProjectRoot SourcePath + "..\"

; Carpeta del build release de Flutter (relativa al repo)
#define BuildReleaseDir ProjectRoot + "build\windows\x64\runner\Release\"

; (Opcional) DB semilla, si quieres empaquetarla
#define SeedDb ProjectRoot + "data\troqueles.db"

; ==== SETUP =================================================================
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
CloseApplications=yes

ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible

; Genera el instalador junto a este .iss
OutputDir={#SourcePath}
OutputBaseFilename=SetupTroqueles
Compression=lzma
SolidCompression=yes
WizardStyle=modern

; Borra EXE previo cuando haces "Clean"
Uninstallable=yes
; (opcional) No hay macro oficial DeleteOutputOnClean, solo comenta si usas Build->Clean Manually

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Copia TODO lo generado por Flutter en Release (dlls, data/, icudtl.dat, plugins/, exe, etc.)
Source: "{#BuildReleaseDir}*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

; (Opcional) Copiar DB semilla si existe en el repo
Source: "{#SeedDb}"; DestDir: "{app}\data"; Flags: ignoreversion; Check: FileExists(ExpandConstant('{#SeedDb}'))

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; \
  Flags: nowait postinstall skipifsilent

[Code]
function FileExists(const FileName: string): Boolean;
begin
  Result := FileSearch(FileName, '') <> '';
end;

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
