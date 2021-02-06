if "%~1" == "" (
	echo Usage:%~nx0 [src-drive] [var-drive-name] [var-vol-name] [var-vol-ser]
	pause
	exit /b 1
)

if "%~2" == "" (
	echo Usage:%~nx0 [src-drive] [var-drive-name] [var-vol-name] [var-vol-ser]
	pause
	exit /b 2
)

if "%~3" == "" (
	echo Usage:%~nx0 [src-drive] [var-drive-name] [var-vol-name] [var-vol-ser]
	pause
	exit /b 3
)

if "%~4" == "" (
	echo Usage:%~nx0 [src-drive] [var-drive-name] [var-vol-name] [var-vol-ser]
	pause
	exit /b 4
)

for /f "tokens=1,2,3,4,5" %%a in ('vol %~d1') do (
	@if "%%a" == "ドライブ" (
		set %~2=%%b
		set %~3=%%e
	) else if "%%a" == "ボリューム" (
		set %~4=%%c
	)

)
