@echo off
setlocal

REM Root directory of the script
set "ROOT_DIR=%~dp0"
cd /d "%ROOT_DIR%"

echo Creating Python virtual environment (venv)...
python -m venv venv
if errorlevel 1 (
    echo Failed to create virtual environment. Please ensure Python is installed and in PATH.
    goto :eof
)

echo Activating virtual environment...
call .\venv\Scripts\activate.bat
if errorlevel 1 (
    echo Failed to activate virtual environment.
    goto :eof
)

echo Upgrading pip...
python -m pip install --upgrade pip

echo Installing Python dependencies from requirements_windows.txt...
pip install -r requirements_windows.txt
if errorlevel 1 (
    echo Failed to install dependencies from requirements_windows.txt.
    echo Please check the file and your internet connection.
    goto :eof
)

echo Installation complete!
echo To start, activate the environment by running: .\venv\Scripts\activate.bat
echo Then you can run your application.

:eof
pause
endlocal
