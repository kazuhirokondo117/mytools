@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set vId=1

for /r %~dp1 %%i in (*.*) do (
	echo !vId!,"%%~nxi"
	set /a vId+=1
)

pause
