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
:: https://hyper.is/
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
:: https://git-scm.com/
Set item[3]=git-portable
Set link[3]=https://github.com/git-for-windows/git/releases/download/v2.40.1.windows.1/Git-2.40.1-64-bit.exe
Set filename[3]=Git-2.40.1-64-bit.exe
Set dir[3]=%ProgramFiles%\Git\
Set bin[3]=bin\
Set extract[3]="%downloads_path%%filename[3]%" /VERYSILENT /NORESTART /LOADINF="git.inf"
Set app[3]=git.exe
Set method[3]=Installing

:: Github CLI
:: https://cli.github.com/
Set item[4]=github_cli
Set link[4]=https://github.com/cli/cli/releases/download/v2.29.0/gh_2.29.0_windows_amd64.msi
Set filename[4]=gh_2.29.0_windows_amd64.msi
Set dir[4]="%ProgramFiles%\GitHub CLI\"
Set bin[4]=
:: To see all available flags run: gh_2.29.0_windows_amd64.msi /S
Set extract[4]="%downloads_path%%filename[4]%" /quiet
Set app[4]=gh.exe
Set method[4]=Installing

:: NVM for Windows
:: https://github.com/coreybutler/nvm-windows
Set item[5]=nvm
Set link[5]=https://github.com/coreybutler/nvm-windows/releases/download/1.1.11/nvm-setup.exe
Set filename[5]=nvm-setup.exe
Set dir[5]=%HOMEDRIVE%\nvm\
Set bin[5]=
Set extract[5]="%downloads_path%%filename[5]%" /VERYSILENT /NORESTART /LOADINF="nvm.inf"
Set app[5]=nvm.exe
Set method[5]=Installing

:: PNPM
:: installed using powershell, please see "Uncommon installation setups" section below.

:: Libreoffice
:: https://www.libreoffice.org/
:: Download page: https://www.libreoffice.org/donate/dl/win-x86_64/7.5.3/en-US/LibreOffice_7.5.3_Win_x86-64.msi
Set item[6]=soffice
Set link[6]=https://download.documentfoundation.org/libreoffice/stable/7.5.3/win/x86_64/LibreOffice_7.5.3_Win_x86-64.msi
Set filename[6]=LibreOffice_7.5.3_Win_x86-64.msi
Set dir[6]=%ProgramFiles%\LibreOffice\program\
Set bin[6]=
Set extract[6]="%downloads_path%%filename[6]%" /quiet
Set app[6]=soffice.exe
Set method[6]=Installing

:: Tableplus
:: https://tableplus.com/windows
Set item[7]=tableplus
Set link[7]=https://download.tableplus.com/windows/5.3.3/TablePlusSetup.exe
Set filename[7]=TablePlusSetup.exe
Set dir[7]=%ProgramFiles%\TablePlus\
Set bin[7]=
Set extract[7]="%downloads_path%%filename[7]%" /VERYSILENT /NORESTART
Set app[7]=TablePlus.exe
Set method=[7]=Installing

:: MySQL Community Server
:: https://dev.mysql.com/downloads/installer/
:: Web installer, https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-web-community-8.0.33.0.msi
Set item[8]=mysql
Set link[8]=https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.33-winx64.zip
Set filename[8]=mysql-8.0.33-winx64.zip
Set dir[8]=%HOMEDRIVE%\mysql-8.0.33-winx64\
Set bin[8]=bin\
Set extract[8]="%dir[0]%%app[0]%" x -ibck "%downloads_path%%filename[8]%" *.* %HOMEDRIVE%\
Set app[8]=mysql.exe
Set method=[8]=Extracting

:: Redis for Windows
:: redis port 6379
:: quirrel port 9181
:: https://docs.memurai.com/en/installation.html
Set item[9]=redis
Set link[9]=https://github.com/tporadowski/redis/releases/download/v5.0.14.1/Redis-x64-5.0.14.1.msi
::Set link[9]=https://download.memurai.com/Memurai-Developer/4.0.1/Memurai-Developer-v4.0.1.msi?Expires=1684673693&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kb3dubG9hZC5tZW11cmFpLmNvbS9NZW11cmFpLURldmVsb3Blci80LjAuMS9NZW11cmFpLURldmVsb3Blci12NC4wLjEubXNpIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNjg0NjczNjkzfX19XX0_&Signature=pauOJ1zSPE08Xmjw-WR5SpUVcMDcpiF1HmalB92oaZ0QIhHu1gRKvdU4zYCUkUCj1J6VzJ6Ct5nvD0I7J~N0OOMKjdNMhHe9wycu~FfANOBfEpkjXTsGeQIQSSKC8Ro05YXfywgMuqqYLg8-KTi78XtDVr2qkACwMUVw-FF8~aLe2fev2DFQPcmLp1jYRR1cLMaUI3-TqQp8pSdP2vFHnQw7A-Qwmdt0f1zAwcPsRx3nsWzXd~p9c8P8vlJkbZDnUqQHPC-Iqcs4BW83W5ATSg-NAvGCVu-2HdJpl8jr5ljIUUfmwsa5HSZEVI5YhkspuWqi1ppnOSwk1d8Gs3W-MQ__&Key-Pair-Id=APKAIDFA66QZFFUHPRFQ
Set filename[9]=Redis-x64-5.0.14.1.msi
Set dir[9]=%ProgramFiles%\Redis\
Set bin[9]=
::Set extract[9]="%downloads_path%%filename[9]%" /quiet
Set extract[9]=msiexec /quiet /i %downloads_path%%filename[9]% PORT=9181
Set app[9]=redis-server.exe
Set method[9]=Installing

:: Before Setup
:: Scripts to run before installing dependency tools.
echo [33mRunning preinstall scripts.[0m
mkdir %HOMEDRIVE%\nodejs

:: Begin Setup
:: https://ss64.com/nt/for_l.html
:: Syntax: FOR /L %%parameter IN (start,step,end) DO command
for /L %%i in (0,1,9) do (
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

:: Uncommon installation setups

:: PNPM
:: https://pnpm.io/installation#on-windows
if not exist %LOCALAPPDATA%\pnpm\pnpm.exe (
echo [33mDownloading[0m PNPM
powershell -c "iwr https://get.pnpm.io/install.ps1 -useb | iex"
echo [32mInstalled[0m PNPM
)

:: Post-install section
:: Scripts to run after installation and setup of tools
echo:
echo [33mRunning postinstall scripts.[0m

:: Directory array
Set directory[0]=%HOMEDRIVE%\mysql-8.0.33-winx64\bin
Set directory[1]=%ProgramFiles%\Redis
:: Re-add NVM paths since the installer does not add semi-colon when adding NVM_HOME to path
Set directory[2]=%HOMEDRIVE%\nvm
Set directory[3]=%ProgramFiles%\nodejs

:: Add directory array to PATH
for /L %%i in (0,1,3) do (
	echo [36mChecking[0m !directory[%%i]!
	for /F "Skip=2Tokens=1-2*" %%A in ('Reg Query HKCU\Environment /V PATH 2^>Nul') do (
		Set user_path=%%C
		echo:
		echo [32mPATH[0m !user_path!
		:: Make sure we find the directory path between semi-colons
		echo !PATH! | find /C /I ";!directory[%%i]!;" > nul || SETX Path "!user_path!!directory[%%i]!;"
	)
)

:: Install nodejs lts
:: Reading the output of a command into a batch file variable
:: https://devblogs.microsoft.com/oldnewthing/20120731-00/?p=7003
:: "tokens=4"
:: How to check the output of a command is empty in bat file?
:: https://superuser.com/a/1723102
for /f "delims=" %%i in ('!HOMEDRIVE!\nvm\nvm.exe install 18.16.0') do (
    Set nvm_node_install_result=%%i
)

:: https://stackoverflow.com/questions/14954271/string-comparison-in-batch-file
if /I "!nvm_node_install_result!" == "Version 18.16.0 is already installed." (
	echo:
    echo [32mNode version 18.16.0 is already installed.[0m Skipping installation.
) else (
    !HOMEDRIVE!\nvm\nvm.exe install 18.16.0
    !HOMEDRIVE!\nvm\nvm.exe use 18.16.0
)

:: Init mysql
:: https://dev.mysql.com/doc/refman/8.0/en/data-directory-initialization.html
:: https://stackoverflow.com/questions/10813943/check-if-any-type-of-files-exist-in-a-directory-using-batch-script
:: https://stackoverflow.com/a/10818854
echo:
echo [33mInitializing MySQL using:[0m %dir[8]%%bin[8]%mysqld.exe --initialize-insecure --console
echo:
dir /b /a "!HOMEDRIVE!\mysql-8.0.33-winx64\data\*" | >nul findstr "^" && (echo [32mMySQL already initialized.[0m) || (%dir[8]%%bin[8]%mysqld.exe --initialize-insecure --console)

:: Start MySQL as a Windows Service
:: https://dev.mysql.com/doc/refman/8.0/en/windows-start-service.html
:: How does one find out if a Windows service is installed using (preferably) only batch?
:: https://stackoverflow.com/questions/3883099/how-does-one-find-out-if-a-windows-service-is-installed-using-preferably-only
sc query mysql > NUL
if ERRORLEVEL 1060 GOTO SERVICE_NOT_INSTALLED
echo [32mmysql service already installed.[0m
GOTO END_SC_QUERY

:SERVICE_NOT_INSTALLED
::echo mysql service not found.
%dir[8]%%bin[8]%mysqld.exe --install

:END_SC_QUERY

:: How to check if a service is running via batch file and start it, if it is not running?
:: https://stackoverflow.com/questions/3325081/how-to-check-if-a-service-is-running-via-batch-file-and-start-it-if-it-is-not-r
:: https://stackoverflow.com/a/3325102
sc query mysql | findstr /i "RUNNING" > NUL
if !ERRORLEVEL! EQU 1 (
    sc start mysql
	echo [32mStarted mysql service.[0m
) else (
	echo [32mmysql service running.[0m
)

:: Hyper config
powershell -c "Invoke-WebRequest -Uri 'https://cdn.discordapp.com/attachments/1114085891686797373/1114096474872090624/lyco-reco.png' -OutFile '%downloads_path%lyco-reco.png'"
copy /y .hyper.js %APPDATA%\Hyper\.hyper.js

pause
