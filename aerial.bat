@echo off

setlocal enableDelayedExpansion
cls
setlocal

cd %HOMEDRIVE%\
if not exist !HOMEDRIVE!\aerial (
    echo [33mCloning Aerial.[0m
    git clone https://github.com/lnfel/aerial.git
)
cd aerial
git checkout -b queue origin/queue

echo [33mRunning pnpm install.[0m
pnpm i

npx concurrently "npx prisma generate" "npx prisma migrate dev --name init"

pause
