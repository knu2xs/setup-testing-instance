#  Setup Testing Instance

1. Run `setup_pro.cmd` as administrator.
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

4. Optional: Install single-use license by running `license-single-use.cmd` as the current user (_not Administrator_).

5. Optional: Setup `arcgis` Conda environment by running `create_arcgis_environment.cmd` as the current user (_not Administrator_). This clones the default `arcgispro-py3` environment and sets ArcGIS Pro to use the new `arcgis` environment.
