######## Phil's dev VM boxstarter script ########

###############
#### notes ####
###############

### running remotely on VM fails on Configuring CredSSP settings
## check http://blogs.technet.com/b/heyscriptingguy/archive/2012/12/30/understanding-powershell-remote-management.aspx

### running locally on VM
## if connected, it will show login screen after restart, but is still working

### other notes
## Boxstarter repeats the _entire_ script after restart. For already-installed packages, Chocolatey will take a couple seconds each to verify. This can get tedious, so consider putting packages that require a reboot near the beginning of the script.
## Boxstarter automatically disables windows update so you don't need to do that at the beginning of the script.

### last run
## completed successfully except for GFW
## required 5 reboots
## took 3.25 hours
## still need to "Update and Restart" afterwards - and to ensure UAC is enabled

######################################
#### make sure we're not bothered ####
######################################

Disable-UAC

######################
#### dependencies ####
######################

## nothing right now

#########################
#### requires reboot ####
#########################

cinst google-chrome-x64
# NOTE: pins itself

cinst VisualStudio2013Ultimate -InstallArguments "/Features:'Blend SQL WebTools Win8SDK WindowsPhone80"

cinst vs2013.4
# NOTE: appears to fail install, but it's not really failing - it's just doing things that require a reboot. Reboots 3x before installation is complete.

cinst dotnet3.5

#######################
#### general utils ####
#######################

cinst 7zip.install
cinst filezilla
cinst Recuva

cinst sysinternals
# NOTE: by default, installs to C:\tools\sysinternals

cinst windirstat
cinst virtualclonedrive

cinst lockhunter
# NOTE: opens webpage after install

######################
#### general apps ####
######################

cinst SublimeText3

cinst keepass.install

###################
#### dev utils ####
###################

cinst fiddler4

cinst autohotkey

cinst githubforwindows
# NOTE: installs asynchronously, boxstarter script continues running. What happens if Boxstarter performs reboot while this is still installing?
# NOTE: install fails
# TODO: figure out how to pin GHFW

cinst tortoisesvn
cinst winmerge
cinst NuGet.CommandLine

##################
#### dev apps ####
##################

cinst scriptcs
cinst stylecop
cinst ankhsvn

cinst resharper -version 8.2.3000.5176
# TODO: keep updating latest version 8.x, since you can't specify to upgrade to the latest version of 8.x

cinst mssqlservermanagementstudio2014express -version 1.0.6
# TODO: remove -version 1.0.6 once approved
# NOTE: this takes up 700mb because it doesn't delete the installer
del "C:\ProgramData\chocolatey\lib\MsSqlServerManagementStudio2014Express.1.0.6\tools\SQLManagementStudio_x64_ENU.exe"

#################################
#### NOW get windows updates ####
#################################

Enable-MicrosoftUpdate
Install-WindowsUpdate -AcceptEula

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

Enable-RemoteDesktop
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowHiddenFilesFoldersDrives -DisableShowProtectedOSFiles
TZUTIL /s "Eastern Standard Time"

Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles}\Sublime Text 3\sublime_text.exe"
Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Fiddler2\Fiddler.exe"
Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\Ssms.exe"

################################
#### restore disabled stuff ####
################################

Enable-UAC

# TODO figure out how to force a restart here, but only once (not every time the script runs)

#########################
#### manual installs ####
#########################

### Teracopy
start http://codesector.com/teracopy

### markdownpad 2.x 
start http://markdownpad.com/download.html

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
