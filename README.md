#  Setup Testing Instance

1. Run `setup_pro_*.cmd` as administrator.
    - Creates directories for setup resources.
        - `C:\setup`
            - `C:\setup\pro`
            - `C:\setup\data`
    - Opens, in Explorer, the locations to retrieve either the daily build or release candidates.
    - Leave this command prompt window open.

2. Copy `setup.msi` with supporting files from correct location to `C:\setup\pro`. The necessary locations are already opened for you in Explorer.

3. Return to the command prompt, press enter and let the script continue. It will... 
    - Install Chocolatey
    - Use Chocolatey to install...
        - 7Zip
        - Git
        - VSCode
        - Anaconda3
        
    - Install ArcGIS Pro for all users.
    - Install and license United States 2021 data.
    - Clone `arcgispro-py3` Conda environment as `arcgis`.
    - Set ArcGIS Pro to use `arcgis` environment.

4. Optional: Install single-use license by running `license-single-use.cmd` as the current user (_not Administrator_).
