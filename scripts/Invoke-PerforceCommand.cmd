@echo off
rem ===================================================================
rem                 Invoke a Custom Perforce Command
rem ===================================================================
rem P4Tar:
rem     http://public.perforce.com/wiki/P4tar
rem     http://public.perforce.com/guest/jeff_grills/p4tar/p4tar.pl
rem     http://public.perforce.com/guest/jeff_grills/p4tar/p4untar.pl
rem ===================================================================

setlocal enableextensions enabledelayedexpansion

rem ============
rem Custom Help Message
rem ============
if "%1" == "help" goto HELP

rem ============
rem Ensure Perforce and Perl Executables are in path
rem ============
for %%f in (perl.exe p4.exe) do (
    if not exist "%%~dp$PATH:f" (
        echo ERROR:  %%f Executable is not in path
        goto EXIT
    )
)

rem ============
rem Tar Command
rem ============
if "%1" == "tar" (

    set TARPATH=%2
    set P4CLIENT=%3
    set P4CHANGE=%4

    if not defined TARPATH (
        echo ERROR:  [%1] command missing argument [path]
        goto HELP
    )

    if not defined P4CLIENT (
        echo ERROR:  [%1] command missing argument [client]
        goto HELP
    ) 

    if not defined P4CHANGE (
        echo ERROR:  [%1] command missing argument [changelist]
        goto HELP
    )

    set P4SCRIPT=%WORKDIR%\Scripts\p4\p4tar.pl
    set TARFILE=!TARPATH!\Change-!P4CLIENT!-!P4CHANGE!.tar
    set TXTFILE=!TARPATH!\Change-!P4CLIENT!-!P4CHANGE!.txt

    if exist !P4SCRIPT! (
        if exist !TARPATH! (
            if not exist !TARFILE! (
                echo perl.exe !P4SCRIPT! -c !P4CHANGE! !TARFILE!
                perl.exe !P4SCRIPT! -c !P4CHANGE! !TARFILE!
                p4.exe change -o !P4CHANGE! > !TXTFILE!
            ) else (
                echo ERROR:  '!TARFILE!' already exists
            )
        ) else (
            echo ERROR:  '!TARPATH!' is not a valid path
        )
    ) else (
        echo ERROR:  Missing !P4SCRIPT! script
    )
    goto EXIT
) 

rem ============
rem UnTar Command
rem ============
if "%1" == "untar" (

    set TARPATH=%2
    set P4CLIENT=%3
    set P4CHANGE=%4

    if not defined TARPATH (
        echo ERROR:  [%1] command missing argument [path]
        goto HELP
    )

    if not defined P4CLIENT (
        echo ERROR:  [%1] command missing argument [client]
        goto HELP
    ) 

    if not defined P4CHANGE (
        echo ERROR:  [%1] command missing argument [changelist]
        goto HELP
    )

    set P4SCRIPT=%WORKDIR%\Scripts\p4\p4untar.pl
    set TARFILE=!TARPATH!\Change-!P4CLIENT!-!P4CHANGE!.tar
    set TXTFILE=!TARPATH!\Change-!P4CLIENT!-!P4CHANGE!.txt

    if exist !P4SCRIPT! (
        if exist !TARPATH! (
            if exist !TARFILE! (
                echo perl.exe %WORKDIR%\Scripts\p4\p4untar.pl -c !P4CHANGE! !TARFILE!
                perl.exe %WORKDIR%\Scripts\p4\p4untar.pl -c !P4CHANGE! !TARFILE!
            ) else (
                echo ERROR:  '!TARFILE!' does not exists
            )
        ) else (
            echo ERROR:  '!TARPATH!' is not a valid path
        )
    ) else (
        echo ERROR:  Missing !P4SCRIPT! script
    )
    goto EXIT
)

rem ============
rem Tar Search
rem ============
if "%1" == "tarfind" (

    set TARPATH=%2

    if not defined TARPATH (
        echo ERROR:  [%1] command missing argument [path]
        goto HELP
    )

    :TARFIND_ARGLOOP
    set CURRARG=%3
    if defined CURRARG (
        if defined ARGLIST (
            set ARGLIST=!ARGLIST! %3
        ) else (
            set ARGLIST=%3
        )
        shift /3

        goto TARFIND_ARGLOOP
    )

    if defined ARGLIST (
        echo ERROR:  [%1] command missing argument [searchargs]
        goto HELP
    ) 

    set TARPATH=!LASTARG!
    set TXTFILE=!TARPATH!\Change-*.txt

    if exist !TARPATH! (
        for %%a in (!TARPATH!\Change-*.txt) do (
            findstr /s /n /i /m !ARGLIST! %%a >NUL 2>&1
            if "!ERRORLEVEL!" EQU "0" (
                echo %%a
            )
        )
    ) else (
        echo ERROR:  '!TARPATH!' is not a valid path
    )

    goto EXIT
)



rem ============
rem Tar Search (Reversed Params for P4Win)
rem ============
if "%1" == "tarfindr" (

    set ARGCOUNT=0
    :TARFINDR_ARGLOOP
    set CURRARG=%2
    if defined CURRARG (
        set /a ARGCOUNT+=1

        set NEXTARG=%3
        if defined NEXTARG (
            if defined ARGLIST (
                set ARGLIST=!ARGLIST! %2
            ) else (
                set ARGLIST=%2
            )
        ) else (
            set LASTARG=%2
        )
        shift /2

        goto TARFINDR_ARGLOOP
    )

    if "!ARGCOUNT!" == "0" (
        echo ERROR:  [%1] command missing argument [path]
        goto HELP
    )

    if "!ARGCOUNT!" == "1" (
        echo ERROR:  [%1] command missing argument [searchargs]
        goto HELP
    ) 

    set TARPATH=!LASTARG!
    set TXTFILE=!TARPATH!\Change-*.txt

    if exist !TARPATH! (
        for %%a in (!TARPATH!\Change-*.txt) do (
            findstr /s /n /i /m !ARGLIST! %%a >NUL 2>&1
            if "!ERRORLEVEL!" EQU "0" (
                echo %%a
            )
        )
    ) else (
        echo ERROR:  '!TARPATH!' is not a valid path
    )

    goto EXIT
)

rem ============
rem Tar Diff
rem ============
if "%1" == "tardiff" (

    set TARPATH=%2
    set P4CLIENT=%3
    set P4CHANGE=%4
    set DIFF=%5

    if not defined TARPATH (
        echo ERROR:  [%1] command missing argument [path]
        goto HELP
    )

    if not defined P4CLIENT (
        echo ERROR:  [%1] command missing argument [client]
        goto HELP
    ) 

    if not defined P4CHANGE (
        echo ERROR:  [%1] command missing argument [changelist]
        goto HELP
    )

    if not defined DIFF (
        echo ERROR:  [%1] command missing argument [diff]
        goto HELP
    )

    :DIFF_ARGLOOP
    set CURRARG=%6
    if defined CURRARG (
        if defined ARGLIST (
            set ARGLIST=!ARGLIST! %6
        ) else (
            set ARGLIST=%6
        )
        shift /6

        goto DIFF_ARGLOOP
    )

    set P4SCRIPT=%WORKDIR%\Scripts\p4\p4tar.pl
    set TARFILE=!TARPATH!\Change-!P4CLIENT!-!P4CHANGE!.tar
    set TXTFILE=!TARPATH!\Change-!P4CLIENT!-!P4CHANGE!.txt
    set TARFILETEMP=!TEMP!\Change-!P4CLIENT!-!P4CHANGE!.tar
    set TXTFILETEMP=!TEMP!\Change-!P4CLIENT!-!P4CHANGE!.txt

    if exist !P4SCRIPT! (
        if exist !DIFF! (
            if exist !TARPATH! (
                if exist !TARFILE! (
                    echo perl.exe !P4SCRIPT! -c !P4CHANGE! !TARFILETEMP!
                    perl.exe !P4SCRIPT! -c !P4CHANGE! !TARFILETEMP!
                    p4.exe change -o !P4CHANGE! > !TXTFILETEMP!
                    if exist !TARFILETEMP! (
                        echo !DIFF! !ARGLIST! !TARFILETEMP! !TARFILE!
                        !DIFF! !ARGLIST! !TARFILETEMP! !TARFILE!
                         del !TARFILETEMP!
                    )
                    if exist !TXTFILETEMP! (
                         echo !DIFF! !ARGLIST! !TXTFILETEMP! !TXTFILE!
                         !DIFF! !ARGLIST! !TXTFILETEMP! !TXTFILE!
                         del !TXTFILETEMP!
                    )
                ) else (
                    echo ERROR:  '!TARFILE!' does not exist
                )
            ) else (
                echo ERROR:  '!TARPATH!' is not a valid path
            )
        ) else (
            echo ERROR:  '!DIFF!' is not a valid diff executable
        )
    ) else (
        echo ERROR:  Missing !P4SCRIPT! script
    )
    goto EXIT
)

rem ============
rem Tar Explore
rem ============
if "%1" == "tarexp" (

    set TARPATH=%2
    set P4CLIENT=%3
    set P4CHANGE=%4

    if not defined TARPATH (
        echo ERROR:  [%1] command missing argument [path]
        goto HELP
    )

    if not defined P4CLIENT (
        echo ERROR:  [%1] command missing argument [client]
        goto HELP
    ) 

    if not defined P4CHANGE (
        echo ERROR:  [%1] command missing argument [changelist]
        goto HELP
    )

    set TARFILE=!TARPATH!\Change-!P4CLIENT!-!P4CHANGE!.tar
    set EXPLORER=explorer
    set EXPLORERARGS=/e,/select

    if exist !TARPATH! (
        if exist !TARFILE! (
            echo !EXPLORER! !EXPLORERARGS!,!TARFILE!
            start !EXPLORER! !EXPLORERARGS!,!TARFILE!
        ) else (
            echo ERROR:  '!TARFILE!' does not exist
        )
    ) else (
        echo ERROR:  '!TARPATH!' is not a valid path
    )
    goto EXIT
)

rem ============
rem Tar Delete
rem ============
if "%1" == "tardel" (

    set TARPATH=%2
    set P4CLIENT=%3
    set P4CHANGE=%4

    if not defined TARPATH (
        echo ERROR:  [%1] command missing argument [path]
        goto HELP
    )

    if not defined P4CLIENT (
        echo ERROR:  [%1] command missing argument [client]
        goto HELP
    ) 

    if not defined P4CHANGE (
        echo ERROR:  [%1] command missing argument [changelist]
        goto HELP
    )

    set TARFILE=!TARPATH!\Change-!P4CLIENT!-!P4CHANGE!.tar
    set TXTFILE=!TARPATH!\Change-!P4CLIENT!-!P4CHANGE!.txt
    set DEL=del

    if exist !TARPATH! (
        if exist !TARFILE! (
            del !TARFILE!
        ) else (
            echo ERROR:  '!TARFILE!' does not exist
        )
        if exist !TXTFILE! (
            del !TXTFILE!
        ) else (
            echo ERROR:  '!TXTFILE!' does not exist
        )
    ) else (
        echo ERROR:  '!TARPATH!' is not a valid path
    )
    goto EXIT
)

rem ============
rem Ticket Cycle
rem ============
if "%1" == "cycle" (

    set PASSPATH=%2

    if not defined PASSPATH (
        echo ERROR:  [%1] command missing argument [path]
        goto HELP
    )

    for %%f in (openssl.exe) do (
        if not exist "%%~dp$PATH:f" (
            echo ERROR:  %%f Executable is not in path
            goto HELP
        )
    )

    set ENCFILE=!PASSPATH!
    set DECFILE=!TEMP!\%RANDOM%.txt

    if exist !ENCFILE! (
        more !ENCFILE! | openssl enc -base64 -d > !DECFILE!
        if exist !DECFILE! (
            p4.exe logout
            p4.exe login < !DECFILE!
            del !DECFILE!
        ) else (
            echo ERROR:  '!DECFILE!' does not exist
        )
    ) else (
        echo ERROR:  Missing !ENCFILE! file
    )
    goto EXIT
)

rem ============
rem Unsuported Command Error Handling
rem ============
echo ERROR:  Unsupported arguments.  Try "%~n0 help".
:LOOP
if "%1" == "" (
    echo.
    goto EXIT
)
echo        [%1]
shift
goto LOOP

rem ============
rem Help Command Display
rem ============
:HELP
echo Invokes a custom Perforce command.
echo.
echo Invoke-PerforceCommand command [arguments]
echo.
echo    command     The custom perforce command.
echo    arguments   The arguments for the command
echo.
echo Supported Commands:
echo    tar      path client changlist
echo             path           The path for tar file
echo             client         The client workspace specification.
echo             changelist     The changelist number
echo.
echo    untar    path client changlist [default]
echo             path           The path for tar file
echo             client         The client workspace specification.
echo             changelist     The changelist number
echo             default        Extract to the default changelist
echo.
echo    tarfind  path searchargs
echo             path           The path for tar file
echo             searchargs     The string to search for 
echo.
echo    tarfindr searchargs path
echo             searchargs     The string to search for 
echo             path           The path for tar file
echo.
echo    tardiff  path client changlist diff [diffargs]
echo             path           The path for tar file
echo             client         The client workspace specification.
echo             changelist     The changelist number
echo             diff           The diff executable
echo             diffargs       diff executable arguments
echo.
echo    tardel   path client changlist
echo             path           The path for tar file
echo             client         The client workspace specification.
echo             changelist     The changelist number
echo.
echo    tarexp   path client changlist
echo             path           The path for tar file
echo             client         The client workspace specification.
echo             changelist     The changelist number
echo.
echo    cycle    path
echo             path           The path for encyrpted password file
echo.

rem ============
rem Exit
rem ============
:EXIT
endlocal
