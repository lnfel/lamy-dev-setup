@echo off

setlocal enableDelayedExpansion
cls
setlocal

:: NOTE: Please run setup.bat first before running the setup aerial project.

Set lamy_dev_setup_path=%USERPROFILE%\Downloads\lamy-dev-setup\

cd %HOMEDRIVE%\
if not exist !HOMEDRIVE!\aerial (
    echo [33mCloning Aerial.[0m
    git clone https://github.com/lnfel/aerial.git
)
cd aerial
git checkout -b queue origin/queue

echo [33mRunning pnpm install.[0m
pnpm i

:: Download settings*
:: https://serverfault.com/questions/1119066/generate-sha256-hash-of-a-string-from-windows-command-line
:: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certutil
:: https://www.ired.team/offensive-security/defense-evasion/t1140-encode-decode-data-with-certutil

:: Download .e file
certutil -decode %lamy_dev_setup_path%efile_base64 %lamy_dev_setup_path%efile_decode > nul
for /f "delims=" %%i in ('findstr /v "hash" %lamy_dev_setup_path%efile_decode') do SET efile_string=%%i
powershell -c "Invoke-WebRequest -Uri 'https://cdn.discordapp.com/attachments/1107897856112730132/1108978053058678874/%efile_string%' -OutFile '.%efile_string%'"

:: Download g file
certutil -decode %lamy_dev_setup_path%gfile_base64 %lamy_dev_setup_path%gfile_decode > nul
for /f "delims=" %%i in ('findstr /v "hash" %lamy_dev_setup_path%gfile_decode') do SET gfile_string=%%i
powershell -c "Invoke-WebRequest -Uri 'https://cdn.discordapp.com/attachments/1107897856112730132/1108033325924356106/%gfile_string%' -OutFile '%gfile_string%'"

:: Create new aerial database
:: https://stackoverflow.com/a/16035183
mysql -u root -e "CREATE DATABASE IF NOT EXISTS aerial;"

:: Generate Prisma client and run database migration
npx concurrently "npx prisma generate" "npx prisma migrate dev --name init"

pause
