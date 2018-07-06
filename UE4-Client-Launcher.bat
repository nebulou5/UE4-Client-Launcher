@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

ECHO #########################################################
ECHO ## UE4-Client-Launcher                                 ##
ECHO ## https://github.com/FuzzySockets/ue4-client-launcher ##
ECHO #########################################################
ECHO.

:start

SET UE_WINDOW_OFFSET=0

:: Prompt user for client count
IF NOT DEFINED UE_CLIENT_COUNT (SET UE_CLIENT_COUNT=1)
SET /P UE_CLIENT_COUNT="How many clients shall we start? (%UE_CLIENT_COUNT%) "
ECHO.

:: Prompt user for window width
IF NOT DEFINED UE_WINDOW_WIDTH (SET UE_WINDOW_WIDTH=1024)
SET /P UE_WINDOW_WIDTH="Window width? (%UE_WINDOW_WIDTH%) "
ECHO.

:: Prompt user for window height
IF NOT DEFINED UE_WINDOW_HEIGHT (SET UE_WINDOW_HEIGHT=768)
SET /P UE_WINDOW_HEIGHT="Window height? (%UE_WINDOW_HEIGHT%) "
ECHO.

:: Open as listen server?
IF NOT DEFINED UE_IS_LISTEN_SERVER (SET UE_IS_LISTEN_SERVER=n)
SET /P UE_IS_LISTEN_SERVER="Open as listen server? (y or n) (%UE_IS_LISTEN_SERVER%) "
IF /I "%UE_IS_LISTEN_SERVER%"=="y" (
  SET UE_URL_PARAMS=?listen
) ELSE (
  SET UE_URL_PARAMS=
)
ECHO.

:: Open logging console?
IF NOT DEFINED UE_IS_LOGGING (SET UE_IS_LOGGING=n)
SET /P UE_IS_LOGGING="With logging? (y or n) (%UE_IS_LOGGING%) "
IF /I "%UE_IS_LOGGING%"=="y" (
  SET UE_WITH_LOG=-log
) ELSE (
  SET UE_WITH_LOG=
)
ECHO.

ECHO Launching %UE_CLIENT_COUNT% Game Clients...

:: For each client, open the game with given settings
FOR /l %%x in (1, 1, %UE_CLIENT_COUNT%) DO (
  ECHO.
  SET /A UE_WINDOW_OFFSET = !UE_WINDOW_OFFSET! + 50
  ECHO Starting Client %%x ...
  START "" "C:\Program Files\Epic Games\UE_4.19\Engine\Binaries\Win64\UE4Editor.exe" "%CD%\Alpha.uproject" /Game/Levels/Entry!UE_URL_PARAMS! -WINDOWED -ResX=!UE_WINDOW_WIDTH! -ResY=!UE_WINDOW_HEIGHT! -WinX=!UE_WINDOW_OFFSET! -WinY=!UE_WINDOW_OFFSET! -game !UE_WITH_LOG!
  CHOICE /d y /t 6 > NUL
)

ECHO.
ECHO Press any key to start more clients...
PAUSE > NUL
ECHO.
GOTO start