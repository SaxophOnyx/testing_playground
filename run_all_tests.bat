@echo off
setlocal enabledelayedexpansion

set FAIL_FAST=0
if "%1"=="--fail-fast" (
    set FAIL_FAST=1
    echo Fail-fast mode enabled
)

cd "data"
echo Running tests for data
call flutter test -r expanded
if errorlevel 1 if %FAIL_FAST%==1 exit /b 1

cd "../features"

for /d %%d in (*) do (
    if exist "%%d\test" (
        echo Running tests for %%d
        cd "%%d"
        call flutter test -r expanded
        if errorlevel 1 if %FAIL_FAST%==1 exit /b 1
        cd ..
    )
)

cd ".."
echo Running integration tests
call patrol test
if errorlevel 1 if %FAIL_FAST%==1 exit /b 1
