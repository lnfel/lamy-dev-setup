@echo off

setlocal enableDelayedExpansion
cls
setlocal
:: Initialize local environment variables

:: General
Set downloads_path=%USERPROFILE%\Downloads\
Set /p downloads_path="Downloads directory [default %USERPROFILE%\Downloads\]: "

:: Check downloads_path
if not exist "%downloads_path%" (
	echo %downloads_path% folder does not exist.
	exit /b 1
)

:: Winrar
Set item[0]=winrar
Set link[0]=https://www.rarlab.com/rar/winrar-x64-602.exe
Set filename[0]=winrar-x64-602.exe
Set dir[0]=%ProgramFiles%\WinRAR\
Set bin[0]=
Set extract[0]="%downloads_path%winrar-x64-602.exe" /S
Set app[0]=WinRAR.exe
Set method[0]=Installing

:: Hyper
Set item[1]=hyper
Set link[1]=https://github.com/vercel/hyper/releases/download/v3.4.1/Hyper-Setup-3.4.1.exe
Set filename[1]=Hyper-Setup-3.4.1.exe
Set dir[1]=%LOCALAPPDATA%\Programs\Hyper\
Set bin[1]=
Set extract[1]="%downloads_path%Hyper-Setup-3.4.1.exe" /S
Set app[1]=Hyper.exe
Set method[1]=Installing

:: Visual Studio Code
:: Download specific version of vscode
:: https://stackoverflow.com/questions/49346733/how-to-downgrade-vscode
:: https://code.visualstudio.com/updates/
:: to download latest version, go to https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user
:: Also note that we are using system setup on the following script
:: Silent install, https://stackoverflow.com/questions/42582230/how-to-install-visual-studio-code-silently-without-auto-open-when-installation
Set item[2]=vscode
Set link[2]=https://update.code.visualstudio.com/1.78.2/win32-x64/stable
Set filename[2]=VSCodeSetup-x64-1.78.2.exe
Set dir[2]="%ProgramFiles%\Microsoft VS Code\"
Set bin[2]=
Set extract[2]="%downloads_path%%filename[2]%" /VERYSILENT /MERGETASKS=!runcode
Set app[2]=Code.exe
Set method[2]=Installing

:: Git
Set item[3]=git-portable
Set link[3]=https://github.com/git-for-windows/git/releases/download/v2.40.1.windows.1/Git-2.40.1-64-bit.exe
Set filename[3]=Git-2.40.1-64-bit.exe
Set dir[3]=%ProgramFiles%\Git\
Set bin[3]=bin\
Set extract[3]="%downloads_path%%filename[3]%" /VERYSILENT /NORESTART /LOADINF="git.inf"
Set app[3]=git.exe
Set method[3]=Installing

:: Github CLI
Set item[4]=github_cli
Set link[4]=https://github.com/cli/cli/releases/download/v2.29.0/gh_2.29.0_windows_amd64.msi
Set filename[4]=gh_2.29.0_windows_amd64.msi
Set dir[4]="%ProgramFiles%\GitHub CLI\"
Set bin[4]=
:: To see all available flags run: gh_2.29.0_windows_amd64.msi /S
Set extract[4]="%downloads_path%%filename[4]%" /quiet
Set app[4]=gh.exe
Set method[4]=Installing

:: Begin Setup
:: https://ss64.com/nt/for_l.html
:: Syntax: FOR /L %%parameter IN (start,step,end) DO command
for /L %%i in (0,1,4) do (
	echo [36mChecking[0m !item[%%i]!
	echo Checking !dir[%%i]!!bin[%%i]!!app[%%i]!
	if exist !dir[%%i]!!bin[%%i]!!app[%%i]! (
		echo [32mFound[0m !item[%%i]!
	) else (
		if not exist !downloads_path!!filename[%%i]! (
			echo [33mDownloading[0m !item[%%i]!
			powershell -c "Invoke-WebRequest -Uri '!link[%%i]!' -OutFile '%downloads_path%!filename[%%i]!'"
			echo [32mDownloaded[0m !item[%%i]!
		) else (
			echo !downloads_path!!filename[%%i]! exist, skipping download.
		)

		echo [33m!method[%%i]![0m !item[%%i]!
		echo Runnning command: !extract[%%i]!
		!extract[%%i]!
		echo [32mInstalled[0m !item[%%i]!
	)
)

pause
