#  Setup Testing Instance

1. Run `setup_01.cmd` as administrator.
    - Creates directories for setup resources.
        - `C:\setup`
            - `C:\setup\pro`
            - `C:\setup\data`
    - Installs Chocolatey
    - Uses Chocolatey to install...
        - 7Zip
        - Git
        - VSCode
        - Anaconda3
    - Retrieves United States 2021 data and license file.
    - Installs and licenses data.
    - Removes `C:\setup\data` to save disk space.
    - Opens, in Explorer, the locations to retrieve either the daily build or release candidates.

2. Copy `setup.msi` installer file, supporting files and single use license file to `C:\setup\pro`.

3.  Run `setup_02.cmd` as administrator.
    - Installs ArcGIS Pro for all users.
    - Authorizes Pro using single use license file.
    - Removes `C:\setup\pro` to save disk space.
    - Clones `arcgispro-py3` Conda environment as `arcgis`.
    - Sets ArcGIS Pro to use `arcgis` environment.
