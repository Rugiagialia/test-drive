# Commandline: START http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/Rugiagialia/test-drive/master/box-demo.ps1

# The following settings will ask you for your windows password and then
# successfuly reboot the machine everytime it needs to. After Boxstarter is
# done autologin won't be enabled.
$Boxstarter.RebootOk=$true    # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true   # Save my password securely and auto-login after a reboot

# Allow running PowerShell scripts
Update-ExecutionPolicy Unrestricted

#region Windows Options
Write-BoxstarterMessage "Setting Taskbar buttons to Never Combine..."
$taskbarButtonsRegKey = 'hkcu:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
if ( ( ( Get-ItemProperty -path $taskbarButtonsRegKey ).TaskbarGlomLevel ) -Ne 2 )
{
    Set-ItemProperty -Path $taskbarButtonsRegKey -Name "TaskbarGlomLevel" -Value 00000002
    Invoke-Reboot
}
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-TaskbarOptions -Size Large -Lock -Dock Bottom
TZUTIL /s "FLE Standard Time"
# Reboot if needed
if (Test-PendingReboot) { Invoke-Reboot }
#endregion

# Disable annoying asking
Disable-UAC

#region InstallChoco
  cinst -y chocolatey
#endregion

#region DotNetAndPowershell
  cinst -y PowerShell
  cinst -y DotNet4.0
  cinst -y DotNet4.5
  cinst -y DotNet4.6.1
  cinst -y DotNet3.5
#endregion

#region Software
cinst -y googlechrome
# Reboot if needed
cinst -y adblockpluschrome
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y jre8
cinst -y skype
cinst -y firefox -packageParameters "l=en-US"
cinst -y flashplayerplugin
# cinst -y adobeshockwaveplayer (failing to install)
cinst -y adobeair
cinst -y cccp
cinst -y adobereader
cinst -y cutepdf
cinst -y 7zip.install
#endregion

#region Tools
cinst -y iperf3
cinst -y crystaldiskinfo
cinst -y sysinternals
#endregion

#region Windows Update
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }
#region

Enable-UAC
Invoke-Reboot
#done
