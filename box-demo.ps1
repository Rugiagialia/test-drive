# Commandline: START http://boxstarter.org/package/url?https://raw.githubusercontent.com/Rugiagialia/test-drive/master/box-demo.ps1

# The following settings will ask you for your windows password and then
# successfuly reboot the machine everytime it needs to. After Boxstarter is
# done autologin won't be enabled.
$Boxstarter.RebootOk=$true    # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true   # Save my password securely and auto-login after a reboot

# Disable annoying asking
Disable-UAC
# Allow running PowerShell scripts
Update-ExecutionPolicy Unrestricted

#region Windows Options
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-TaskbarOptions -Size Large -Lock -Dock Bottom -Combine Full
TZUTIL /s "FLE Standard Time"
#endregion

#region InstallChoco
  cinst chocolatey
#endregion

#region DotNetAndPowershell
  cinst PowerShell
  cinst DotNet4.0
  cinst DotNet4.5
  cinst DotNet3.5
#endregion

#region Software
cinst googlechrome
cinst adblockpluschrome
cinst jre8
cinst skype
cinst firefox -packageParameters "l=en-US"
cinst flashplayerplugin
cinst adobeshockwaveplayer
cinst adobeair
cinst cccp
cinst adobereader
cinst cutepdf
cinst 7zip.install
#endregion

#region Tools
cinst iperf3
cinst crystaldiskinfo
cinst sysinternals
#endregion

#region Windows Update
Install-WindowsUpdate -acceptEula
#region

Enable-UAC
Invoke-Reboot
#done
