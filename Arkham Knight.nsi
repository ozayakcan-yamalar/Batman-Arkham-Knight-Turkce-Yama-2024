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
  !define MUI_PRODUCT "Batman Arkham Knight"
  !define MUI_PRODUCT_SHORT "Batman AK"
  !define MUI_PRODUCT_YAMA "${MUI_PRODUCT} Turkce Yama"
  !define MUI_PRODUCT_YAMA_KALDIR "${MUI_PRODUCT_YAMA} Kaldir"
  !define MUI_PRODUCT_YAMA_SHORT "${MUI_PRODUCT_SHORT} Turkce Yama"
  Name "${MUI_PRODUCT_YAMA}"
  OutFile "${MUI_PRODUCT_YAMA}.exe"
  !define MUI_ICON "icon.ico"
  !define MUI_UNICON "icon.ico"
  !define PRODUCT_VERSION "1.0.0.0"
  VIProductVersion "${PRODUCT_VERSION}"
  VIFileVersion "${PRODUCT_VERSION}"
  VIAddVersionKey "FileVersion" "${VERSION}"
  VIAddVersionKey "LegalCopyright" "(C) Ozay Akcan."
  VIAddVersionKey "FileDescription" "${MUI_PRODUCT} son surumu icin turkce yama kurar"
  Unicode True

  ;Default installation folder
  InstallDir "C:\"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\${MUI_PRODUCT_YAMA}" ""

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

Section "${MUI_PRODUCT_YAMA_SHORT}" SecIns


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
  WriteRegStr HKCU "Software\${MUI_PRODUCT_YAMA}" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\${MUI_PRODUCT_YAMA_KALDIR}.exe"

SectionEnd


Function .onInit
  SectionSetFlags ${SecIns} 17
FunctionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecIns ${LANG_TURKISH} "${MUI_PRODUCT} son surumu icin turkce yama kurar."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecIns} $(DESC_SecIns)
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

  Delete "$INSTDIR\${MUI_PRODUCT_YAMA_KALDIR}.exe"
  
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

  DeleteRegKey /ifempty HKCU "Software\${MUI_PRODUCT_YAMA}"

SectionEnd