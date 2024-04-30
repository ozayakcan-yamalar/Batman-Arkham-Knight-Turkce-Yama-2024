#   MUI_EXTRAPAGES.nsh
#   By Red Wine Jan 2007
 
!verbose push
!verbose 3
 
!ifndef _MUI_EXTRAPAGES_NSH
!define _MUI_EXTRAPAGES_NSH
 
!ifmacrondef MUI_EXTRAPAGE_README & MUI_PAGE_README & MUI_UNPAGE_README
 
!macro MUI_EXTRAPAGE_README UN ReadmeFile
!verbose push
!verbose 3
   !define MUI_PAGE_HEADER_TEXT "Yama kurulumundan önce mutlaka okuyun."
   !define MUI_PAGE_HEADER_SUBTEXT " "
   !define MUI_LICENSEPAGE_TEXT_TOP "Dikkat Edilmesi Gerekenler:"
   !define MUI_LICENSEPAGE_TEXT_BOTTOM " "
   !define MUI_LICENSEPAGE_BUTTON "$(^NextBtn)"
   !insertmacro MUI_${UN}PAGE_LICENSE "${ReadmeFile}"
!verbose pop
!macroend
 
!define ReadmeRun "!insertmacro MUI_EXTRAPAGE_README"
 
 
!macro MUI_PAGE_README ReadmeFile
!verbose push
!verbose 3
    ${ReadmeRun} "" "${ReadmeFile}"
!verbose pop
!macroend
 
 
!macro MUI_UNPAGE_README ReadmeFile
!verbose push
!verbose 3
    ${ReadmeRun} "UN" "${ReadmeFile}"
!verbose pop
!macroend
 
!endif
!endif
 
!verbose pop