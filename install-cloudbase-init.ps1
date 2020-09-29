cmd /c curl -LO https://github.com/cloudbase/cloudbase-init/releases/download/1.1.2/CloudbaseInitSetup_1_1_2_x64.msi

# configure the installer
# https://github.com/cloudbase/windows-openstack-imaging-tools/blob/master/UnattendResources/Logon.ps1#L585
$msiexecArgumentList = "/i CloudbaseInitSetup_1_1_2_x64.msi /qn /l*v c:\log"
$serialPortName = ""
if (!$serialPortName) {
    $serialPorts = Get-WmiObject Win32_SerialPort
    if ($serialPorts) {
        $serialPortName = $serialPorts[0].DeviceID
    }
}
$msiexecArgumentList += " LOGGINGSERIALPORTNAME=$serialPortName"
$msiexecArgumentList += " RUN_SERVICE_AS_LOCAL_SYSTEM=1"

Start-Process -Wait -PassThru -FilePath msiexec -ArgumentList $msiexecArgumentList