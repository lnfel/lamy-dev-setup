@echo off

setlocal enableDelayedExpansion
cls
setlocal

git config --global user.name "Dale Ryan Aldover"
git config --global user.email "bk2o1.syndicates@gmail.com"

echo [32mGit config set with:[0m

for /f "delims=" %%i in ('git config --global user.name') do (
    Set name=%%i
    echo Name: !name!
)

for /f "delims=" %%i in ('git config --global user.email') do (
    Set email=%%i
    echo E-mail: !email!
)

pause
