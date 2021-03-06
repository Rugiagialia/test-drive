# Commandline: START http://boxstarter.org/package/url?https://raw.githubusercontent.com/Rugiagialia/test-drive/master/box-demo-7.ps1

# The following settings will ask you for your windows password and then
# successfuly reboot the machine everytime it needs to. After Boxstarter is
# done autologin won't be enabled.
$Boxstarter.RebootOk=$true    # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true   # Save my password securely and auto-login after a reboot

# Allow running PowerShell scripts
Update-ExecutionPolicy Unrestricted

#region Windows Options
Write-BoxstarterMessage "Setting Time Zone to FLE Standard Time"
TZUTIL /s "FLE Standard Time"
#endregion

# Disable annoying asking
Disable-UAC

#region InstallChoco
  cinst -y chocolatey
#endregion

#region DotNetAndPowershell
  cinst -y PowerShell
  cinst -y powershell-packagemanagement
  cinst -y DotNet4.0
  cinst -y DotNet4.5
  cinst -y DotNet4.6.1
  cinst -y DotNet3.5
#endregion

#region Software
cinst -y googlechrome
# Reboot needed
cinst -y adblockpluschrome
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

#region SoftwareToConsider
#cinst unchecky
cinst -y silverlight
cinst -y cdburnerxp
#cinst windirstat
#cinst foxitreader
#cinst spotify
#cinst cpu-z
#cinst picasa
#cinst owncloud-client
#cinst adblockplus-firefox
#cinst adblockplusie
#cinst sudo
#cinst gpg4win-light
#cinst windowsrepair
#cinst clamwin (Antivirus)
#cinst mousewithoutborders
#cinst ultradefrag
#cinst processhacker.portable
#cinst kcleaner
#cinst prey
#cinst perfview

#region Tools
#cinst -y iperf3
cinst -y crystaldiskinfo
#cinst -y sysinternals
#endregion

#region Windows Update
#Install-WindowsUpdate -acceptEula
#region

#region CleanUp
del "C:\Users\Public\Desktop\acrobat*.lnk"
#region

Enable-UAC
#region ToDo
#load default user hive and change windows settings/screens/etc. 
#region


#done
