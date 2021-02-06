@echo off
:Proc-Begin
	setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
	
	if "%~1" == "" (
		echo Usage:%~nx0 [src-drv]
		pause
		exit /b 1
	)
	if not exist "%~d1" (
		echo not exist source-drive-letter [drv=%~d1]
		pause
		exit /b 2
	)
	set myAppPath=C:\Users\kazuh\Documents\apps\CPRMDecrypter
:Proc-Main
	set myCmd=%myAppPath%\cprmgetkey.exe %~d1
	for /f "tokens=1,2,3" %%a in ('%myCmd%') do (
		if "%%a" == "ContentsKey" (
			echo ---------------------
			echo cprmkey=%%c
			echo ---------------------
		)
	)
:Proc-End
	echo %date: =0% %time: =0% %~nx0 command successfully
	pause
