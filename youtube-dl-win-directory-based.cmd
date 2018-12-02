@echo off
setlocal EnableDelayedExpansion

set path=%path%;%~dp0

for /f "tokens=*" %%a in ('dir /b /a:d "%~dp0" ^| findstr ","') do (
rem echo "%%a"
for /f "tokens=*" %%b in ('echo %%a^| sed "s/^.*,//"') do (
rem echo "%%b"
for /f "tokens=*" %%r in ('
curl -o /dev/null -s "https://www.youtube.com/channel/%%b/videos" -w "%%{http_code}"') do (
if %%r EQU 200 (
echo %%b belongs to channel
cd "%~dp0%%a"
echo "channel %%b"> file.log
youtube-dl --config-location "%~dp0youtube.config" -i --download-archive archive.log https://www.youtube.com/channel/%%b/videos
)
)
for /f "tokens=*" %%r in ('
curl -o /dev/null -s "https://www.youtube.com/user/%%b/videos" -w "%%{http_code}"') do (
if %%r EQU 200 (
echo %%b belongs to user
cd "%~dp0%%a"
echo "user %%b"> file.log
youtube-dl --config-location "%~dp0youtube.config" -i --download-archive archive.log https://www.youtube.com/user/%%b/videos
)
)

)

)
endlocal
