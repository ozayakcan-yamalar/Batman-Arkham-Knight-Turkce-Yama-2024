;NSIS Modern User Interface
;Basic Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

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

  !insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
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

  SetOutPath "$INSTDIR\BmGame\CookedPCConsole"
  
  ;Store installation folder
  WriteRegStr HKCU "Software\Batman Arkham Knight Turkce Yama" "" $INSTDIR
  
  
  ExecShellWait print "$INSTDIR\BmGame\CookedPCConsole\copy.cmd"

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

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
;Uninstaller Section

Section
File /r "CookedPCConsole\*"
SectionEnd

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\Batman Arkham Knight Turkce Yama"

SectionEnd