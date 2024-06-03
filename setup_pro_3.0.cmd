ECHO OFF

NET SESSION >nul 2>&1

IF %ERRORLEVEL% EQU 0 (
   ECHO.

) ELSE (

   ECHO.-------------------------------------------------------------
   ECHO ERROR: YOU ARE NOT RUNNING THIS WITH ADMINISTRATOR PRIVILEGES.
   ECHO. -------------------------------------------------------------
   ECHO. If you're seeing this, it means you don't have admin privileges!
   ECHO.
   ECHO. You will need to restart this script with Administrator privileges by right-clicking and select "Run As Administrator"
   PAUSE

   EXIT /B 1
)

IF NOT EXIST "C:/setup" MKDIR "C:/setup"
IF NOT EXIST "C:/setup/pro" MKDIR "C:/setup/pro"

ECHO. Please copy ArcGIS Pro installation resources to C:/setup/pro
explorer \\metro
explorer \\archive2\ProSetups
explorer C:\setup\pro
PAUSE

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco feature enable -n=allowGlobalConfirmation

choco install 7zip 

choco install vscode
setx /M path "%path%;C:\Program Files\Microsoft VS Code\bin"

choco install git 

choco install anaconda3
setx /M path "%path%;C:\tools\Anaconda3;C:\tools\Anaconda3\condabin"

choco install dotnet-desktopruntime

CALL refreshenv

START /WAIT msiexec.exe /i "C:\setup\pro\ArcGISPro.msi" /qb ALLUSERS=1 SOFTWARE_CLASS=Professional AUTHORIZATION_TYPE=SINGLE_USE ACCEPTEULA=yes LOCK_AUTH_SETTINGS=FALSE

IF NOT EXIST "D:/data/ba_data" MKDIR "D:/data/ba_data"

CALL robocopy "\\redarchive4\business_analyst_public\US_2024\Builds\3.3.1.3\ESRI_BA_2024_US_Data_Update" "D:/data/ba_data/usa_2024" /mir /mt /z

CALL "%PROGRAMFILES%\ArcGIS\Pro\bin\DataLicInstall.exe" "\\redarchive4\business_analyst_public\US_2024\Builds\3.3.1.3\SDLICs\Internal-BA-USA-2024-NAT-MPI-05_27_25.sdlic"

conda create -n arcgis --clone "%PROGRAMFILES%\ArcGIS\Pro\bin\Python\envs\arcgispro-py3"

CALL "%PROGRAMFILES%\ArcGIS\Pro\bin\Python\Scripts\proenv.bat" -p "C:\tools\Anaconda3\envs\arcgis"
