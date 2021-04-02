# Download and install Chocolatey
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Confirm all actions for chocolatey so we don't get caught up by yes/no prompts in the automation
choco feature enable -n allowGlobalConfirmation

# Setup packages 
choco install 7zip
choco install awscli
choco install dbeaver
choco install vscode
#choco install microsoft-teams
choco install python3 --pre 
choco install anaconda3
choco install office365business
choco install googlechrome
choco install notepadplusplus
#choco install redshift-odbc
# choco install pip

# #Installing packages
# pip install io xgboost errno calendra pickle timesdatetime datetime dateutil warnings operator zipfile36 logging subprocess32 regex h5py dask more-itertools pyoperators catboost
