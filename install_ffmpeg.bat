@ECHO off
@setlocal EnableDelayedExpansion



@set LF=^


@SET command=#
@FOR /F "tokens=*" %%i in ('findstr -bv @ "%~f0"') DO SET command=!command!!LF!%%i
@powershell -noprofile -noexit -command !command! & goto:eof

#Requires -RunAsAdministrator
Set-ExecutionPolicy RemoteSigned
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name 7Zip4Powershell
Try 
{
    Get-Item -Path .\ffmpeg-git-full.7z
}
Catch 
{
    Invoke-WebRequest -URI https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z -OutFile .\ffmpeg-git-full.7z
}
if (-Not (Test-Path -Path 'C:\Program Files\ffmpeg'))
{
    Expand-7Zip -ArchiveFileName .\ffmpeg-git-full.7z -TargetPath 'C:\Program Files\ffmpeg'
}
if((Get-ChildItem -Path 'C:\Program Files\ffmpeg').Length -eq 1)
{
    (Get-ChildItem -Path 'C:\Program Files\ffmpeg')[0] | Move-Item -Destination 'C:\Program Files\ffmpeg1' -Force
    Remove-Item -Path 'C:\Program Files\ffmpeg' -Force -Recurse
    Rename-Item -Path 'C:\Program Files\ffmpeg1' -NewName 'C:\Program Files\ffmpeg'
}
New-Item -ItemType Directory -Force -Path C:\Scripts -ErrorAction SilentlyContinue | out-null
Copy-Item -Path .\vidcmp.ps1 -Destination C:\Scripts\vidcmp.ps1 -Force
[System.Environment]::GetEnvironmentVariable('PATH','USER') | New-Variable -Name oldpath
[System.Environment]::SetEnvironmentVariable('PATH',((Get-Variable -Name oldpath).Value + ';C:\Scripts'),'USER')
if($?)
{
    Write-Output 'Install complete restart powershell to use'
}
Exit