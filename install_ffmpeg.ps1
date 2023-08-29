#Requires -RunAsAdministrator
Set-ExecutionPolicy RemoteSigned
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name 7Zip4Powershell
try 
{
    Get-Item -Path .\ffmpeg-git-full.7z
}
catch 
{
    Invoke-WebRequest -URI https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z -OutFile .\ffmpeg-git-full.7z
}
$ffmpeg_path = "C:\Program Files\ffmpeg"
Expand-7Zip -ArchiveFileName .\ffmpeg-git-full.7z -TargetPath $ffmpeg_path
(Get-ChildItem -Path $ffmpeg_path)[0]. | Move-Item -Destination "C:\Program Files\ffmpeg1" -Force
Remove-Item -Path $ffmpeg_path -Force -Recurse
Rename-Item -Path "C:\Program Files\ffmpeg1" -NewName $ffmpeg_path
(Get-ChildItem -Path 'C:\Program Files\ffmpeg')[0] | Move-Item -Destination 'C:\Program Files\ffmpeg1' -Force
Remove-Item -Path 'C:\Program Files\ffmpeg' -Force -Recurse
Rename-Item -Path 'C:\Program Files\ffmpeg1' -NewName 'C:\Program Files\ffmpeg'