echo OFF

NET SESSION >nul 2>&1

IF %ERRORLEVEL% EQU 0 (
   echo.

) ELSE (

   echo.-------------------------------------------------------------
   echo ERROR: YOU ARE NOT RUNNING THIS WITH ADMINISTRATOR PRIVILEGES.
   echo. -------------------------------------------------------------
   echo. If you're seeing this, it means you don't have admin privileges!
   echo.
   echo. You will need to restart this script with Administrator privileges by right-clicking and select "Run As Administrator"
   pause

   EXIT /B 1
)

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco feature enable -n=allowGlobalConfirmation

choco install 7zip 
choco install vscode 
choco install git 
choco install anaconda3

IF NOT EXIST "C:/setup" MKDIR "C:/setup"
IF NOT EXIST "C:/setup/pro" MKDIR "C:/setup/pro"
IF NOT EXIST "C:/setup/data" MKDIR "C:/setup/data"

XCOPY "\\redarchive4\business_analyst_public\US_2021\Builds\2.8.0.8\ESRI_BA_2021_US_Data_Update" "C:\setup\data\" /E /H
XCOPY "\\redarchive4\business_analyst_public\US_2021\Builds\2.8.0.8\SDLICs\BA_2021_US_NAT_Data_Bundle_w_MPI.sdlic" "C:\setup\data"

START /WAIT msiexec.exe /i "C:\setup\data\setup.msi" /qb AgreeToLicense=Yes
START /WAIT "C:\Program Files\ArcGIS\Pro\bin\DataLicInstall.exe" "C:\setup\data\BA_2021_US_NAT_Data_Bundle_w_MPI.sdlic"

RMDIR /q /s C:\setup\data

EXPLORER \\metro
EXPLORER \\archive2\ProSetups
