@echo off
rem ===================================================================
rem                      RegEdit Delete Icon Streams
rem ===================================================================
rem http://www.colincochrane.com/post/2007/10/Windows-Vista-Disappearing-System-Tray-Icons-Fix.aspx
rem ===================================================================

rem ============
rem Custom Help Message
rem ============
if [%1]==[help] goto :HELP

rem ============
rem  Run the Reg Command
rem ============
for %%f in (reg.exe) do (
    if exist "%%~dp$PATH:f" (
        reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /f /v IconStreams
        reg delete "HKCR\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /f /v IconStreams
        reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /f /v PastIconsStream
        reg delete "HKCR\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /f /v PastIconsStream
    ) else (
        echo Cannot find %%f executable in the path
    )
)
goto EXIT

rem ============
rem Help Command Display
rem ============
:HELP
echo Clears the Icon Streams from the Tray notification area in windows. See http://www.colincochrane.com/post/2007/10/Windows-Vista-Disappearing-System-Tray-Icons-Fix.aspx for mre information
echo.
echo RegEdit-DeleteIconStreams
echo.

rem ============
rem Exit
rem ============
:EXIT
