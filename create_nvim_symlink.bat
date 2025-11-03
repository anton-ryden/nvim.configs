@echo off
set "SCRIPT_DIR=%~dp0"
set "SOURCE_DIR=%SCRIPT_DIR%"
set "TARGET_DIR=%LOCALAPPDATA%\nvim"

echo Creating symlink from %SOURCE_DIR% to %TARGET_DIR% on Windows...
mklink /D "%TARGET_DIR%" "%SOURCE_DIR%" >nul 2>&1
if %errorlevel% equ 0 (
    echo Symlink created successfully.
) else (
    echo Failed to create symlink. Run as Administrator if needed.
)
pause
