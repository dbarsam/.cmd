@echo off
setlocal enabledelayedexpansion
rem ===================================================================
rem                        Set Console Color
rem ===================================================================

if "%1" == "" (
    echo Missing Foreground Color Parameter
    goto help
)
if "%2" == "" (
    echo Missing Background Color Parameter
    goto help
)

for %%c in (%1, %2) do (
    if "%%c" == "Black"       set SCRIPTCOLOR=!SCRIPTCOLOR!0
    if "%%c" == "DarkBlue"    set SCRIPTCOLOR=!SCRIPTCOLOR!1
    if "%%c" == "DarkGreen"   set SCRIPTCOLOR=!SCRIPTCOLOR!2
    if "%%c" == "DarkAqua"    set SCRIPTCOLOR=!SCRIPTCOLOR!3
    if "%%c" == "DarkRed"     set SCRIPTCOLOR=!SCRIPTCOLOR!4
    if "%%c" == "DarkPurple"  set SCRIPTCOLOR=!SCRIPTCOLOR!5
    if "%%c" == "DarkYellow"  set SCRIPTCOLOR=!SCRIPTCOLOR!6
    if "%%c" == "DarkGray"    set SCRIPTCOLOR=!SCRIPTCOLOR!7
    if "%%c" == "LightGray"   set SCRIPTCOLOR=!SCRIPTCOLOR!8
    if "%%c" == "LightBlue"   set SCRIPTCOLOR=!SCRIPTCOLOR!9
    if "%%c" == "LightGreen"  set SCRIPTCOLOR=!SCRIPTCOLOR!A
    if "%%c" == "LightAqua"   set SCRIPTCOLOR=!SCRIPTCOLOR!B
    if "%%c" == "LightRed"    set SCRIPTCOLOR=!SCRIPTCOLOR!C
    if "%%c" == "LightPurple" set SCRIPTCOLOR=!SCRIPTCOLOR!D
    if "%%c" == "LightYellow" set SCRIPTCOLOR=!SCRIPTCOLOR!E
    if "%%c" == "White"       set SCRIPTCOLOR=!SCRIPTCOLOR!F
)

if defined SCRIPTCOLOR echo color %SCRIPTCOLOR% && color %SCRIPTCOLOR%
goto exit

rem ============
rem Help Command Display
rem ============
:help
echo Set the color on dos console with the color
echo.
echo Set-ConsoleColor [fg] [bg]
echo    fg       The foreground color value
echo    bg       the background color value
echo.
echo    Black
echo    DarkBlue
echo    DarkGreen
echo    DarkAqua
echo    DarkRed
echo    DarkPurple
echo    DarkYellow
echo    DarkGray
echo    LightGray
echo    LightBlue
echo    LightGreen
echo    LightAqua
echo    LightRed
echo    LightPurple
echo    LightYellow
echo    White
echo.
echo e.g.
echo    Set-ConsoleColor DarkGray Black

rem ============
rem Exit
rem ============
:exit
setlocal
