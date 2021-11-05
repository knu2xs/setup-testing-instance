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
choco install git 
choco install anaconda3 --params '"/AddToPath"'

START /WAIT msiexec.exe /i "C:\setup\pro\ArcGISPro.msi" /qb ALLUSERS=1 SOFTWARE_CLASS=Professional AUTHORIZATION_TYPE=SINGLE_USE ACCEPTEULA=yes

"C:\Program Files\ArcGIS\Pro\bin\SoftwareAuthorizationPro.exe" /LIF "\\Esri.com\software\Esri\Released\Authorization_Files\ArcGISPro2.9\Single Use\Pro_AdvancedSU.prvc" /s

REG import "\\redarchive4\business_analyst_public\US_2021\US_2021_Install_Workaround\US_2021_Installation_Workaround.reg"
START /WAIT msiexec.exe /i "\\redarchive4\business_analyst_public\US_2021\Builds\2.8.0.8\ESRI_BA_2021_US_Data_Update\setup.msi" /qb AgreeToLicense=Yes

"C:\Program Files\ArcGIS\Pro\bin\DataLicInstall.exe" "\\redarchive4\business_analyst_public\US_2021\Builds\2.8.0.8\SDLICs\BA_2021_US_NAT_Data_Bundle_w_MPI.sdlic"

conda create -n arcgis --clone "%PROGRAMFILES%\ArcGIS\Pro\bin\Python\envs\arcgispro-py3"

"C:\Program Files\ArcGIS\Pro\bin\Python\Scripts\proswap.bat" -p "C:\tools\Anaconda3\envs\arcgis"
