# Commandline: START http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/Rugiagialia/test-drive/master/box.ps1

### other notes
## Boxstarter repeats the _entire_ script after restart. For already-installed packages, Chocolatey will take a couple seconds each to verify. This can get tedious, so consider putting packages that require a reboot near the beginning of the script.
## Boxstarter automatically disables windows update so you don't need to do that at the beginning of the script.
## still need to "Update and Restart" afterwards - and to ensure UAC is enabled

# The following settings will ask you for your windows password and then
# successfuly reboot the machine everytime it needs to. After Boxstarter is
# done autologin won't be enabled.
$Boxstarter.RebootOk=$true    # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true   # Save my password securely and auto-login after a reboot

#### make sure we're not bothered ####

Disable-UAC

# Install Windows Update and reboot
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }

# Install software (reboot required)

# Install software (no reboot)

#region DotNetAndPowershell
  cinst PowerShell
  cinst DotNet4.0
  cinst DotNet4.5
  cinst DotNet3.5
#endregion

#region Software
cinst 7zip.install
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
cinst dropbox
cinst googledrive
cinst owncloud-client
#endregion

#region Tools
cinst iperf3
cinst crystaldiskinfo
cinst listary
cinst sysinternals
#endregion

#cinst flashplayeractivex (Win XP, 7 Only)
#cinst office365business
#cinst airdroid
#cinst itunes

#######################
#### general utils ####
#######################


# NOTE: by default, installs to C:\tools\sysinternals
#cinst lockhunter
# NOTE: opens webpage after install

# Make sure some windows update didn't creep on us after installing all
# those apps
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }

#################
#### cleanup ####
#################

del C:\eula*.txt
del C:\install.*
del C:\vcredist.*
del C:\vc_red.*

###############################
#### windows configuration ####
###############################

### do this here so that it only happens once (shouldn't reboot any more at this point)
#### Windows Options ####

Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-TaskbarOptions -Size Large -Lock -Dock Bottom -Combine Full
TZUTIL /s "FLE Standard Time"

#Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles}\Sublime Text 3\sublime_text.exe"
#Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Fiddler2\Fiddler.exe"
#Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
#Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\Ssms.exe"

################################
#### restore disabled stuff ####
################################

Enable-UAC

# TODO figure out how to force a restart here, but only once (not every time the script runs)

#########################
#### manual installs ####
#########################

### Teracopy
#start http://codesector.com/teracopy

### markdownpad 2.x 
#start http://markdownpad.com/download.html

## MS Office 2013
# link to ISO?




###########################
#### optional installs ####
###########################

### host machines
# cinst Microsoft-Hyper-V-All -source windowsFeatures

### general utils
# cinst imgburn
# cinst bulkrenameutility
# cinst dropbox
## causes reboot
## opens UI after restart
# cinst mpc-hc

## ditto
# start http://ditto-cp.sourceforge.net/
## this causes weirdness with Mouse Without Borders

### general apps
# cinst Kindle
# cinst skype
# cinst foxitreader

### dev utils
# cinst ilmerge
# cinst ilspy

### sql server
# cinst mssqlserver2012express

### web dev
# cinst IIS-WebServerRole -source windowsfeatures
# cinst webpi
# cinst ASPNET45 -source webpi
# cinst WindowsAzureSDK_2_5 -source webpi
## doesn't work

### non-VM
# cinst steam
# start http://www.vudu.com//flash/VUDUToGo.exe
# cinst unity
