@echo off
setlocal

set "RL_DIR=%LOCALAPPDATA%\RuneLite"
set "MSG="

REM Check if all three versions exist
if exist "%RL_DIR%\RuneLite.exe" if exist "%RL_DIR%\RuneLiteV.exe" if exist "%RL_DIR%\RuneLiteA.exe" (
    del "%RL_DIR%\RuneLiteA.exe"
    REM Rerun the batch after deleting
    call "%~f0"
    exit /b
)

REM If V version exists, make it active
if exist "%RL_DIR%\RuneLiteV.exe" (
    if exist "%RL_DIR%\RuneLite.exe" (
        ren "%RL_DIR%\RuneLite.exe" RuneLiteA.exe
    )
    ren "%RL_DIR%\RuneLiteV.exe" RuneLite.exe
    set "MSG=The RuneLite launcher will now open vanilla RuneLite"
    goto :showmsg
)

REM If A version exists, make it active
if exist "%RL_DIR%\RuneLiteA.exe" (
    if exist "%RL_DIR%\RuneLite.exe" (
        ren "%RL_DIR%\RuneLite.exe" RuneLiteV.exe
    )
    ren "%RL_DIR%\RuneLiteA.exe" RuneLite.exe
    set "MSG=The RuneLite launcher will now open azolite"
    goto :showmsg
)

set "MSG=Error: no additional executable files found"

:showmsg
powershell.exe -NoProfile -WindowStyle Hidden -Command ^
"Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('%MSG%','RuneLite launcher')"

endlocal
