# About

It is always better to use default settings when everything works for you. But it never happens, and everyone periodically changes or overrides them. Here comes the main problem, you cannot track every change you have made to any option. The best solution to the problem is to write down everything you have changed in a config file. A configuration file, irrespective of its type, is a backup of all the game settings you have overridden according to your preferences. There are many reasons behind it, such as if you want to share all the changes with your friends, switch to a new machine, know your old preferences as you messed up default settings, recently formatted your device, etc. This repository contains game-related files, including configurations.

## Table of contents

- [Quickstart](#quickstart)
- [Windows](#windows)
  - [BulkUninstall](#bulkuninstall)
  - [Bulkinstall](#bulkinstall)
  - [Post-Processing](#post-processing)
- [Games](#games)

## Quickstart

## Windows

Open a PowerShell terminal (version 5.1 or later) and run:

Sets the PowerShell execution policies to run a remote scripts

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### BulkUninstall

Uninstalling Pre-installed apps using winget package manager.

```powershell
irm https://raw.githubusercontent.com/semisoft0072/Configuration/main/After-Windows-11/BulkUninstall.ps1 | iex
```

### Bulkinstall

Installing Apps, Dependency, Extensions using winget and scoop package manager.

```powershell
irm https://raw.githubusercontent.com/semisoft0072/Configuration/main/After-Windows-11/BulkInstall.ps1 | iex
```

### Post-Processing

Importing config and changing windows settings.

```powershell
irm https://raw.githubusercontent.com/semisoft0072/Configuration/main/After-Windows-11/Post-Processing.ps1 | iex
```

## Games

- [Counter-Strike: Global Offensive](https://github.com/semisoft0072/Configuration/tree/main/Configs/Games/CSGO)
