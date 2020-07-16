set vCmdHome=%~dp0
@rem -- set vDataHome=%userprofile%\Documents\mydata
set vDataHome=A:\mydata
set vDataCsv=%vDataHome%\db\csv
set vDataText=%vDataHome%\db\text
set myCmdLogDir=%userprofile%\Documents\log

if not exist %myCmdLogDir% md %myCmdLogDir%
