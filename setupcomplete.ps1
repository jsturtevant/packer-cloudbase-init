# must run the setupcomplete command
# https://github.com/cloudbase/cloudbase-init-installer/blob/ca6fd7f8d10436f4896fcdb7af6ccbc16ef11619/CloudbaseInitSetup/Actions/SysprepActions.js#L171
Remove-Item -Force C:\Windows\Setup\Scripts\SetupComplete.cmd
& "$ENV:ProgramFiles\Cloudbase Solutions\Cloudbase-Init\bin\SetSetupComplete.cmd"