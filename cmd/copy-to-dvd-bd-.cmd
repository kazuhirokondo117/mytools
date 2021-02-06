@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set /p myDestDriveName="dest drive?[d/e/f]"
for /f "tokens=1" %%a in ('powershell "get-volume %myDestDriveName%|%% { $_.SizeRemaining }"') do set myFreeSize=%%a
echo !myFreeSize!
for /r %1 %%x in ("*.*") do (
	if not exist "d:\MOVIE-FILES\%%~nxx" (
		if !myFreeSize! gtr %%~zx (
			echo copy "%%~dpnxx" %myDestDriveName%:\MOVIE-FILES
			echo --- file-size=%%~zx / !myFreeSize! ---
			copy "%%~dpnxx" %myDestDriveName%:\MOVIE-FILES
			set /a myFreeSize-=%%~zx
		) else (
			goto :Proc-End
		)
	)
)
:Proc-End
	pause
