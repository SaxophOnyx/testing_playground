@echo off
cd "data"
echo Running tests for data
call flutter test -r expanded

cd "../features"

for /d %%d in (*) do (
    if exist "%%d/test" (
        echo Running tests for %%d
        cd "%%d"
        call flutter test -r expanded
        cd ..
    )
)

cd ".."
echo Running integration tests
call patrol test

echo Press Enter to exit...
pause > nul