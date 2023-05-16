## Lamy Dev Setup for emergencies

Tools that will be installed:
- WinRar
- Hyper
- VSCode
- Git
- Github CLI
- NVM for Windows
- PNPM
- Libreoffice

## Just some notes for myself

Create new github repo from current directory (must be a git repo first)
```s
gh repo create lamy-dev-setup --public --source=. --remote=origin
```

### TODO
- [x] Configure git installation options during silent install. (https://github.com/git-for-windows/git/wiki/Silent-or-Unattended-Installation)

Generate config file by running the installer using:
```s
Git-2.40.1-64-bit.exe /SAVEINF="git.inf"
```
Select the options wanted and it will generate a file named `git.inf` on the same directory as the installer. We can then keep the file and load it during silent install. The install command should look like the following:
```s
Git-2.40.1-64-bit.exe /VERYSILENT /NORESTART /LOADINF="git.inf"
```

Source: https://superuser.com/questions/944576/git-for-windows-silent-install-silent-arguments

