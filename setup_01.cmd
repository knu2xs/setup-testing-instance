SET DIR=%~dp0%

%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://community.chocolatey.org/install.ps1','%DIR%install.ps1'))"
%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%DIR%install.ps1' %*"

REFRESHENV

choco install 7zip vscode git anaconda3 -y

REFRESHENV

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
