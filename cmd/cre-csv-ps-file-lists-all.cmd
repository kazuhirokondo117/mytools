set vPsCmd="C:\Users\winridge\Documents\tools\ps1\cre-csv-file-lists_all.ps1"
set vSrcPath="C:\Users\winridge\Documents\workspace\svn-work\ドキュメント\再開発"
set vDestPath="C:\Users\winridge\Documents\mydata\csv\ps_file_lists_all.csv"

powershell %vPsCmd% %vSrcPath% %vDestPath%

pause
