@echo off
REM ===================================================================
REM                  Dos Environment Set-up File
REM -------------------------------------------------------------------
REM                              ViM
REM ===================================================================

REM ==============
REM Custom Aliases
REM ==============
for %%f in (vim.exe) do (
    if exist "%%~dp$PATH:f" (
        doskey ;vimdiff=vim -d
    )
)

for %%f in (gvim.exe) do (
    if exist "%%~dp$PATH:f" (
        doskey ;profile=gvim %~dp0..\profile.cmd
        doskey ;gvimdiff=gvim -d
    )
)

goto EXIT
REM ==============
REM Error Handling
REM ==============
:ERROR

REM ===================================================================
REM End of Script
REM ===================================================================
:EXIT

