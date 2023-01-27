#define nwjsFolder "C:\Users\dpass\Documents\nwjs\"

[Setup] 
AppName=DCS Olympus 
AppVerName=DCS Olympus Alpha v0.0.2
DefaultDirName={usersavedgames}\DCS.openbeta
DefaultGroupName=DCSOlympus  
OutputBaseFilename=DCSOlympus
  
[Tasks] 
; NOTE: The following entry contains English phrases ("Create a desktop icon" and "Additional icons"). You are free to translate them into another language if required. 
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked


[Files] 
; NOTE: Don't use "Flags: ignoreversion" on any shared system files 
Source: "..\scripts\OlympusExport.lua"; DestDir: "{app}\Scripts"; Flags: ignoreversion 
Source: "..\scripts\OlympusHook.lua"; DestDir: "{app}\Scripts\Hooks"; Flags: ignoreversion 
Source: "..\scripts\OlympusCommand.lua"; DestDir: "{app}\Mods\Services\Olympus\Scripts"; Flags: ignoreversion 
Source: "..\scripts\unitPayloads.lua"; DestDir: "{app}\Mods\Services\Olympus\Scripts"; Flags: ignoreversion
Source: "..\scripts\OlympusMission.lua"; DestDir: "{app}\Mods\Services\Olympus\Scripts"; Flags: ignoreversion 
Source: "..\scripts\mist_4_4_90.lua"; DestDir: "{app}\Mods\Services\Olympus\Scripts"; Flags: ignoreversion 
Source: "..\bin\*.dll"; DestDir: "{app}\Mods\Services\Olympus\bin"; Flags: ignoreversion;
Source: "..\client\bin\*"; DestDir: "{app}\Mods\Services\Olympus\client\bin"; Flags: ignoreversion;
Source: "..\client\node_modules\*"; DestDir: "{app}\Mods\Services\Olympus\client\node_modules"; Flags: ignoreversion recursesubdirs;
Source: "..\client\public\*"; DestDir: "{app}\Mods\Services\Olympus\client\public"; Flags: ignoreversion recursesubdirs;
Source: "..\client\routes\*"; DestDir: "{app}\Mods\Services\Olympus\client\routes"; Flags: ignoreversion recursesubdirs;
Source: "..\client\views\*"; DestDir: "{app}\Mods\Services\Olympus\client\views"; Flags: ignoreversion recursesubdirs;
Source: "..\client\*.*"; DestDir: "{app}\Mods\Services\Olympus\client"; Flags: ignoreversion;
Source: "{#nwjsFolder}\*.*"; DestDir: "{app}\Mods\Services\Olympus\client"; Flags: ignoreversion recursesubdirs;

[Code]
function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKCU,
    'Environment',
    'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  { look for the path with leading and trailing semicolon }
  { Pos() returns 0 if not found }
  Result := Pos(';' + Param + ';', ';' + OrigPath + ';') = 0;
end;

[Registry]
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "DCSOLYMPUS_PATH"; ValueData: "{app}\Mods\Services\Olympus"; Flags: preservestringtype
Root: HKCU; Subkey: "Environment"; ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};%DCSOLYMPUS_PATH%\bin"; Check: NeedsAddPath('%DCSOLYMPUS_PATH%\bin');
	
[Setup]
; Tell Windows Explorer to reload the environment
ChangesEnvironment=yes

[Icons]
Name: "{userdesktop}\DCS Olympus Client"; Filename: "{app}\Mods\Services\Olympus\client\nw.exe"; Tasks: desktopicon