@echo off

setlocal enableDelayedExpansion
cls
setlocal

:: Reading the output of a command into a batch file variable
:: https://devblogs.microsoft.com/oldnewthing/20120731-00/?p=7003
:: "tokens=4"
:: How to check the output of a command is empty in bat file?
:: https://superuser.com/a/1723102
for /f "delims=" %%i in ('!HOMEDRIVE!\nvm\nvm.exe install 18.16.0') do (
    Set RESULT=%%i
    echo The result is !RESULT!
)

if /I "!RESULT!" == "Version 18.16.0 is already installed." (
    echo Node version 18.16.0 is already installed. Skipping installation.
) else (
    !HOMEDRIVE!\nvm\nvm.exe install 18.16.0
    !HOMEDRIVE!\nvm\nvm.exe use 18.16.0
)

::Set install_node=%HOMEDRIVE%\nvm\nvm.exe install 18.16.0

::if ('!install_node!') EQU "Version 18.16.0 is already installed." do (
::    echo "Version 18.16.0 is already installed."
::)

:: https://stackoverflow.com/questions/10813943/check-if-any-type-of-files-exist-in-a-directory-using-batch-script
:: https://stackoverflow.com/a/10818854
dir /b /a "!HOMEDRIVE!\mysql-8.0.33-winx64\data\*" | >nul findstr "^" && (echo MySQL already initialized.) || (C:\mysql-8.0.33-winx64\bin\mysqld.exe --initialize-insecure --console)

:: How does one find out if a Windows service is installed using (preferably) only batch?
:: https://stackoverflow.com/questions/3883099/how-does-one-find-out-if-a-windows-service-is-installed-using-preferably-only
sc query mysql > NUL
if ERRORLEVEL 1060 GOTO SERVICE_NOT_INSTALLED
echo mysql service exists.
GOTO END_SC_QUERY

:SERVICE_NOT_INSTALLED
echo mysql service not found.

:END_SC_QUERY

:: How to check if a service is running via batch file and start it, if it is not running?
:: https://stackoverflow.com/questions/3325081/how-to-check-if-a-service-is-running-via-batch-file-and-start-it-if-it-is-not-r
:: https://stackoverflow.com/a/3325102
sc query mysql | findstr /i "RUNNING" > NUL
::echo %ERRORLEVEL%
if !ERRORLEVEL! EQU 1 (
    sc start mysql
)

:: https://serverfault.com/questions/1119066/generate-sha256-hash-of-a-string-from-windows-command-line
:: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certutil
:: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/find
:: https://www.ired.team/offensive-security/defense-evasion/t1140-encode-decode-data-with-certutil
:: https://stackoverflow.com/questions/9524239/save-output-from-find-command-to-variable
:: https://stackoverflow.com/questions/8898088/single-line-for-statement-i-unexpected-at-this-time
:: for /f "delims=" %%i in ('certutil -decode efile_base64 efile_decode ^> nul ^| findstr /v "hash" efile_decode') do SET sample=%%i
certutil -decode efile_base64 efile_decode > nul
for /f "delims=" %%i in ('findstr /v "hash" efile_decode') do SET sample=%%i

echo Sample: %sample%

pause
