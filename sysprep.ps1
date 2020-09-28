Write-Output '>>> Waiting for GA Service (RdAgent) to start ...'
while ((Get-Service RdAgent).Status -ne 'Running') { Start-Sleep -s 5 }
Write-Output '>>> Waiting for GA Service (WindowsAzureTelemetryService) to start ...'
while ((Get-Service WindowsAzureTelemetryService) -and ((Get-Service WindowsAzureTelemetryService).Status -ne 'Running')) { Start-Sleep -s 5 }
Write-Output '>>> Waiting for GA Service (WindowsAzureGuestAgent) to start ...'
while ((Get-Service WindowsAzureGuestAgent).Status -ne 'Running') { Start-Sleep -s 5 }
Write-Output '>>> Sysprepping VM ...'
if( Test-Path $Env:SystemRoot\system32\Sysprep\unattend.xml ) {
  Remove-Item $Env:SystemRoot\system32\Sysprep\unattend.xml -Force
}
$unattendedXml = "$ENV:ProgramFiles\Cloudbase Solutions\Cloudbase-Init\conf\Unattend.xml"
Write-Output $unattendedXml
& $Env:SystemRoot\System32\Sysprep\Sysprep.exe /oobe /generalize /mode:vm /quit /quiet /unattend:$unattendedXml

#try waiting for sysprep to finish
while($true) {
  $imageState = Get-process "sysprep" 

  if ($imageState) { Write-Output "found" } else { break }
  Start-Sleep -s 5
}

# standard wait as packer docs describe
while($true) {
  $imageState = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State).ImageState
  Write-Output $imageState
  if ($imageState -eq 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { break }
  Start-Sleep -s 5
}

#try waiting for sysprep to finish
while($true) {
  $imageState = Get-process "sysprep" 

  if ($imageState) { Write-Output "found" } else { break }
  Start-Sleep -s 6
}

#try waiting for sysprep to finish
Start-Sleep -s 1200
Write-Output '>>> Sysprep complete ...'
