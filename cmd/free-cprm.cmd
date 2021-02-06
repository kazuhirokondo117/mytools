:Proc-Begin
	set myRc=
	set myMsg=

	if "%~1" == "" (
		set myMsg=Usage:%~nx0 [src-file]
		set myRc=1
		goto :Proc-End
	)
	
	if not exist "%~dpnx1" (
		set myMsg=file not exist [src-file=%~1]
		set myRc=2
		goto :Proc-End
	)
:Proc-Main
	set myAppPath=C:\Users\kazuh\Documents\apps\CPRMDecrypter
	set /p myCprmKey="cprm-key:"
	echo %myAppPath%\\c2dec -R "%~dpnx1" "%~dp1..\%~nx1"

	if %errorlevel% neq 0 (
		set myMsg=command failler!! cmd=c2dec
		set myRc=1
		goto :Proc-End
	)
:Proc-End
	if defined myMsg (
		echo %myMsg%
		pause
	)
	if defined myRc (
		exit /b %myRc%
	)
	pause
