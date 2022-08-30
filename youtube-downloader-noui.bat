@echo off
title YouTube Downloader Version 2.0

:menu
cls
echo ############################################################
echo ############################################################
echo ###############......#######################################
echo ###############............#################################
echo ###############..................###########################
echo ###############........................#####################
echo ###############..............................###############
echo ###############........................#####################
echo ###############..................###########################
echo ###############............#################################
echo ###############......#######################################
echo ############################################################
echo ############################################################
echo.
echo         Y O U T U B E          D O W N L O A D E R
echo.

:: Syntaxe de la commande
:: youtube-downloader-noui.bat <audio/video1080/customRes | subcommand> <link> <playlistMode : "True" to enable> <filename> <height>

set subcommand=%1%
set format=%1%
set link=%2%
set runPlaylistMode=%3%
set filename=%4%

:: SUBCOMMANDS
if %subcommand%==help goto :HELP
if %subcommand%==formats goto :GET_VIDEO_FORMATS

:: VIDEO DOWNLOAD PARAMETERS
if %format%==customRes goto :videoCustomRes_download
if %format%==audio goto :audio_download
if %format%==video1080 goto :video1080_download

echo Error : Invalid Parameter (format)
echo Supported formats : audio, video1080
goto :END

:audio_download
if %runPlaylistMode%==True goto :audio_download_PlaylistMode
yt-dlp.exe -f (bestaudio[ext=m4a]) -o $DOWNLOADS/%filename%.m4a %link%
goto :DONE

:video1080_download
if %runPlaylistMode%==True goto :video1080_download_PlaylistMode
yt-dlp.exe -f (bestvideo[height=1080][ext=mp4])+(bestaudio[ext=m4a]) -o $DOWNLOADS/%filename% %link%
goto :DONE

:audio_download_PlaylistMode
yt-dlp.exe -i --yes-playlist -f (bestaudio[ext=m4a]) %link%
goto :DONE

:video1080_download_PlaylistMode
yt-dlp.exe -i --yes-playlist -f (bestvideo[height=1080][ext=mp4])+(bestaudio[ext=m4a]) %link%
goto :DONE

:videoCustomRes_download
set videoHeight=%5%
yt-dlp.exe -f (bestvideo[height=%videoHeight%][ext=mp4])+(bestaudio[ext=m4a]) -o $DOWNLOADS/%filename% %link%
goto :DONE


:: NICE

:HELP
echo Help for YouTubeDownloader
echo.
echo Command Syntax (video download) : youtube-downloader-noui.bat [FORMAT] [LINK] [PLAYLIST MODE] [FILENAME] [HEIGHT (if format is "customRes")]
echo Command Syntax (subcommands) : youtube-downloader-noui [SUBCOMMAND] [LINK (if required)]
echo.
echo IMPORTANT INFORMATION
echo It is required to put the link in between quotation marks for the program to run properly !
echo You can also use the "https://youtu.be/yourvideoid" that works without the use of quotation marks !
echo.
echo SUBCOMMANDS
echo help : displays help for the program
echo formats : displays video formats available for the provided video link
echo.
echo DOWNLOAD OPTIONS
echo Supported formats : audio, video1080, customRes (enter height of video (example : 1280x720 (720p) = 720))
echo To download a playlist, please enter "True" in [PLAYLIST MODE] and enter the playlist link in [LINK].
echo.
echo All files are downloaded into the "$DOWNLOADS" folder.
goto :END

:DONE
color a
echo.
echo DONE
echo Files can be found in \$DOWNLOADS\
goto :END

:GET_VIDEO_FORMATS
yt-dlp.exe --list-formats %link%
pause
goto :END

:END
color f
cd D:\PROGRAMMES\YouTubeDL\YT-DLP\
