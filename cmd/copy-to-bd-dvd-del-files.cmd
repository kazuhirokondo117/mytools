@echo off
set /p myDestDriveName="dest drive?[d/e/f]"
for /r %1 %%x in ("*.*") do (
	@if exist "%myDestDriveName%:\MOVIE-FILES\%%~nxx" (
		echo del "%%~dpnxx" 
		echo del "%%~dpnxx"1>> %userprofile%\Documents\logs\vr_delete_files.log
		del "%%~dpnxx"
	)
)
