@echo off

:Proc-Begin
	setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

	@rem // import profile 
	call %~dp0profile.cmd

	if "%~1" == "" (
		echo Usage:%~nx0 [src-dir]
		exit /b 1
	)

	if not exist "%~1" (
		echo directory not exist!! [src-dir:%~1]
		exit /b 2
	)

	set vDestFile=%vDataCsv%\mmd_file_lists.csv

	if not exist "%vDestFile%" (
		echo id,vol_name,file_name,path,file_ext,attributes_map,created,file_size> %vDestFile%
	)	

	for /f "tokens=1 delims=," %%x in (%vDestFile%) do set myId=%%x

	if /i "!myId!" == "id" set myId=

	call %~dp0get-vol.cmd %~d1 myDriveName_ myVolName_ myVolSer_

:Proc-Main
	set vSrcDir=%~dp1
	echo src-dir:%vSrcDir% vol-name:%myVolName_%
	set mySeq=
	set /p myDoAction="Do action[view/csv/quit]?:"
	if /i "%myDoAction:~0,1%" == "q" goto :Proc-End
	
	for /r "%vSrcDir%" %%i in ("*.*") do (
		set /a myId+=1
		set /a mySeq+=1
		if /i "%myDoAction:~0,1%" == "v" (
			echo !myId!,"%myVolName_%","%%~nxi","%%~pi","%%~xi","%%~ai","%%~ti","%%~zi",!mySeq!
		) else if /i "%myDoAction:~0,1%" == "c" (
			echo !myId!,"%myVolName_%","%%~nxi","%%~pi","%%~xi","%%~ai","%%~ti","%%~zi",!mySeq!>> %vDestFile%
		) else (
			echo Illigal do action!!
			goto :Proc-End
		)
	)


	if not "%~2" == "" (
		shift /1
		goto :Proc-Main
	)
:Proc-End
	pause
