@rem // set postgressql home

if "%~1" == "" (
	echo Usage:%~nx0 [work-dir]
	pause
	exit /b 1
)

set POSTGRESSQL_HOME="C:\Program Files\PostgreSQL\13"

@rem // set execute path
set PATH=%PATH%;%POSTGRESSQL_HOME%\bin

cd /d "%~1"

%comspec% /k