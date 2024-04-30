;NSIS Modern User Interface
;Basic Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
  !include "nsdialogs.nsh"
  !include "${__FILEDIR__}\MUI_README.nsh"

;--------------------------------
;General

  ;Name and file
  Name "Batman Arkham City Turkce Yama"
  OutFile "Batman Arkham City Turkce Yama.exe"
  Unicode True

  ;Default installation folder
  InstallDir "C:\"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\Batman Arkham Knight Turkce Yama" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_README "Readme.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "Turkish"

;--------------------------------
;Installer Sections

Section "Batman AK Turkce Yama" SecBatmanAK


  ;Install Localizations
  SetOutPath "$INSTDIR\BmGame\Localization\INT"

  File /r "InstallFiles\Localization\*"
  
  SetOutPath "$INSTDIR\BmGame\Movies"

  File /r "InstallFiles\Movies\*"
  
  SetOutPath "$INSTDIR\BmGame\CookedPCConsole"
  
  File /r "InstallFiles\CookedPCConsole\backupFont.cmd"

  nsExec::ExecToLog "$INSTDIR\BmGame\CookedPCConsole\backupFont.cmd"

  File /r "InstallFiles\CookedPCConsole\*"

  ;Store installation folder
  WriteRegStr HKCU "Software\Batman Arkham Knight Turkce Yama" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Batman Arkham Knight Turkce Yama Kaldir.exe"

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecBatmanAK ${LANG_TURKISH} "Batman Arkham Knight son surumu icin turkce yama kurar."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecBatmanAK} $(DESC_SecBatmanAK)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------

;--------------------------------
;Run Post Install Commands

Section

  ;Install Localizations

  SetOutPath "$INSTDIR\BmGame\Localization\INT"
  nsExec::ExecToLog "$INSTDIR\BmGame\Localization\INT\install.cmd"
  Delete "$INSTDIR\BmGame\Localization\INT\install.cmd"

  ;Font
  SetOutPath "$INSTDIR\BmGame\CookedPCConsole"
  Delete "$INSTDIR\BmGame\CookedPCConsole\backupFont.cmd"

  ;Install Movies
  SetOutPath "$INSTDIR\BmGame\Movies"
  nsExec::ExecToLog "$INSTDIR\BmGame\Movies\backup.cmd"
  nsExec::ExecToLog "$INSTDIR\BmGame\Movies\usm.cmd"
  Delete "$INSTDIR\BmGame\Movies\restoreBackups.cmd"
  Delete "$INSTDIR\BmGame\Movies\backup.cmd"
  Delete "$INSTDIR\BmGame\Movies\Gibbed.IO.dll"
  Delete "$INSTDIR\BmGame\Movies\us.exe"
  Delete "$INSTDIR\BmGame\Movies\usm.cmd"
  Delete "$INSTDIR\BmGame\Movies\ch10_press_gathers.txt"
  Delete "$INSTDIR\BmGame\Movies\ending.txt"
  Delete "$INSTDIR\BmGame\Movies\intro.txt"
  Delete "$INSTDIR\BmGame\Movies\intro_part_2.txt"

  ;Install CookedPCConsole
  SetOutPath "$INSTDIR\BmGame\CookedPCConsole"
  nsExec::ExecToLog "$INSTDIR\BmGame\CookedPCConsole\backup.cmd"
  nsExec::ExecToLog "$INSTDIR\BmGame\CookedPCConsole\move.cmd"
  SetOutPath "$INSTDIR\BmGame\CookedPCConsole\Temporary"
  nsExec::ExecToLog "$INSTDIR\BmGame\CookedPCConsole\Temporary\decomp.cmd"
  SetOutPath "$INSTDIR\BmGame\CookedPCConsole"
  nsExec::ExecToLog "$INSTDIR\BmGame\CookedPCConsole\afterDecomp.cmd"

  ;Delete Command Files
  nsExec::ExecToLog "$INSTDIR\BmGame\CookedPCConsole\del.cmd"
  Delete "$INSTDIR\BmGame\CookedPCConsole\afterDecomp.cmd"
  Delete "$INSTDIR\BmGame\CookedPCConsole\backup.cmd"
  Delete "$INSTDIR\BmGame\CookedPCConsole\move.cmd"
  Delete "$INSTDIR\BmGame\CookedPCConsole\del.cmd"
  Delete "$INSTDIR\BmGame\CookedPCConsole\restoreBackups.cmd"

  SetOutPath "$INSTDIR"

SectionEnd
;--------------------------------


;Uninstaller Section
Section "Uninstall"


  SetOutPath "$INSTDIR\BmGame\Localization\INT"

  File /r "UnistallFiles\restoreBackups.cmd"

  nsExec::ExecToLog "$INSTDIR\BmGame\Localization\INT\restoreBackups.cmd"

  SetOutPath "$INSTDIR\BmGame\Movies"

  File /r "UnistallFiles\restoreBackups.cmd"

  nsExec::ExecToLog "$INSTDIR\BmGame\Movies\restoreBackups.cmd"

  SetOutPath "$INSTDIR\BmGame\CookedPCConsole"

  File /r "UnistallFiles\restoreBackups.cmd"

  nsExec::ExecToLog "$INSTDIR\BmGame\CookedPCConsole\restoreBackups.cmd"

  Delete "$INSTDIR\Batman Arkham Knight Turkce Yama Kaldir.exe"
  
  RMDir "$INSTDIR\BmGame\CookedPCConsole\Temporary"

  Delete "$INSTDIR\BmGame\CookedPCConsole\afterDecomp.cmd"
  Delete "$INSTDIR\BmGame\CookedPCConsole\backup.cmd"
  Delete "$INSTDIR\BmGame\CookedPCConsole\backupFont.cmd"
  Delete "$INSTDIR\BmGame\CookedPCConsole\move.cmd"
  Delete "$INSTDIR\BmGame\CookedPCConsole\del.cmd"
  Delete "$INSTDIR\BmGame\CookedPCConsole\restoreBackups.cmd"
  Delete "$INSTDIR\BmGame\Movies\restoreBackups.cmd"
  Delete "$INSTDIR\BmGame\Localization\INT\restoreBackups.cmd"
  Delete "$INSTDIR\BmGame\Movies\backup.cmd"
  Delete "$INSTDIR\BmGame\Movies\Gibbed.IO.dll"
  Delete "$INSTDIR\BmGame\Movies\us.exe"
  Delete "$INSTDIR\BmGame\Movies\usm.cmd"
  Delete "$INSTDIR\BmGame\Movies\ch10_press_gathers.txt"
  Delete "$INSTDIR\BmGame\Movies\ending.txt"
  Delete "$INSTDIR\BmGame\Movies\intro.txt"
  Delete "$INSTDIR\BmGame\Movies\intro_part_2.txt"

  DeleteRegKey /ifempty HKCU "Software\Batman Arkham Knight Turkce Yama"

SectionEnd