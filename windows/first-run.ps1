@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%systemdrive%\chocolatey\bin

cinst firefox
cinst dropbox
cinst 1password
cinst pidgin
cinst gvim
cinst steam

cinst conemu
cinst putty
cinst gow
cinst githubforwindows

cinst 7zip
cinst notepadplusplus
cinst filezilla
cinst iTunes
cinst vlc
cinst GoogleChrome

cinst sysinternals

cinst nodejs.install
cinst VisualStudio2012WDX

junction c:\users\james\documents\WindowsPowerShell C:\Users\james\Dropbox\code\dotfiles\windows\WindowsPowerShell