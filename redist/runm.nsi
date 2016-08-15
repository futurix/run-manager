!include "MUI.nsh"

Name "Run Manager"
OutFile runm.exe
InstallDir "$PROGRAMFILES\Run Manager"
SetCompressor lzma

BrandingText "Run Manager 1.02"

!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"


Section ""
  SetOutPath $INSTDIR
  
  File ..\release\runm.exe
  File ..\release\runm.chm
  File license.txt
  
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\RunManager" "DisplayName" "Run Manager 1.02"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\RunManager" "UninstallString" '"$INSTDIR\uninst.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\RunManager" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\RunManager" "NoRepair" 1
  WriteUninstaller "uninst.exe"

  CreateShortCut "$SMPROGRAMS\Run Manager.lnk" "$INSTDIR\runm.exe"
SectionEnd


Section "Uninstall"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\RunManager"

  Delete $INSTDIR\runm.exe
  Delete $INSTDIR\runm.chm
  Delete $INSTDIR\license.txt
  Delete $INSTDIR\uninst.exe

  Delete "$SMPROGRAMS\Run Manager.lnk"

  RMDir "$INSTDIR"
SectionEnd

