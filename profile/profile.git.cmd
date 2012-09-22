@echo off
REM ===================================================================
REM                  Dos Environment Set-up File
REM -------------------------------------------------------------------
REM                             GitMSYS
REM ===================================================================

REM ==================
REM Custom Environment
REM ==================
REM Needed for this: http://code.google.com/p/msysgit/issues/detail?id=184
set TERM=msys

REM ==============
REM Custom Aliases
REM ==============
doskey ;gitstatus=git status
doskey ;gitdiff=git difftool -y $*
doskey ;gitupdate=git submodule foreach git pull origin master

goto EXIT
REM ==============
REM Error Handling
REM ==============
:ERROR

REM ===================================================================
REM End of Script
REM ===================================================================
:EXIT

