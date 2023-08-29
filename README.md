# Fixed file size video compressor script
This is a script to automatically calculate the required bitrate and call ffmpeg in order to keep the file size at or below the requirement file size. Very useful in order to compress a video so that it fits in *Discord*'s upload file rescrictions.
## Installation
1. Install `git` if not installed
2. Open `Powershell` or `cmd`
3. Clone the repo by running `git clone https://github.com/Rocket009/Video-Compressor-Script.git`
4. Run `cd Video-Compressor-Script`
5. Execute the ffmpeg installer by running `.\install_ffmpeg.bat`
6. After its complete restart your terminal
## Running
This command is added to your User PATH Environment Variable so you can run it at any directory
1. Open the directory that the video is in `Powershell` or `cd` to it. *Note: you must execute it in powershell*
2. Run `vidcmp filename` This will compress and override the video file and compress it to 20 MiB
### Additonal Arguments
The script contains additional arguments to be passed in order to do different things
- `Filename` is the default argument that must be passed containing the filename of the file to compress.
- `Filesize` is the size of the output file in MiB. It has a default value of 20 MiB
- `Output` is the name of the output file. Its default value is equal to `Filename`.
### Examples
- `vidcmp filename`     Compresses and overwrites file with a file size of 20 MiB
- `vidcmp -Filename filename.mp4 -Filesize 10 -Output compressed.mp4`   Compresses the file to 10 MiB and saves it as compressed.mp4