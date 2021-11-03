START /WAIT msiexec.exe /i "C:\setup\pro\ArcGISPro.msi" /qb ALLUSERS=1 SOFTWARE_CLASS=Professional AUTHORIZATION_TYPE=SINGLE_USE ACCEPTEULA=yes

START /WAIT "%PROGRAMFILES%\ArcGIS\Pro\bin\SoftwareAuthorizationPro.exe" /LIF C:/setup/Pro_AdvancedSU.prvc /s

RMDIR /q /s C:\setup\pro

RUN conda create -n arcgis --clone "%PROGRAMFILES%\ArcGIS\Pro\bin\Python\envs\arcgispro-py3"

RUN "C:\Program Files\ArcGIS\Pro\bin\Python\Scripts\proswap.bat" -p "C:\tools\Anaconda3\envs\arcgis"
