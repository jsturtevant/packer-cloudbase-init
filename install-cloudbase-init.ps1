cmd /c curl -LO https://github.com/cloudbase/cloudbase-init/releases/download/1.1.2/CloudbaseInitSetup_1_1_2_x64.msi
$msiexecArgumentList = "/i CloudbaseInitSetup_1_1_2_x64.msi /qn /l*v c:\log"
Start-Process -Wait -PassThru -FilePath msiexec -ArgumentList $msiexecArgumentList