param([Parameter(Mandatory=$true)][string]$Filename,
[float]$Filesize=20,
[string]$Output=$Filename)
$duration = C:\'Program Files'\ffmpeg\bin\ffprobe.exe -i $Filename -show_entries format=duration -v quiet -of csv="p=0"
$bitrate = (($Filesize * 8388.608) / $duration).ToString() + "k"
C:\'Program Files'\ffmpeg\bin\ffmpeg.exe -y -i $Filename -pass 1 -b:v $bitrate $Output
C:\'Program Files'\ffmpeg\bin\ffmpeg.exe -y -i $Filename -pass 2 -b:v $bitrate $Output