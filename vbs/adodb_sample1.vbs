Option Explicit

Const adOpenStatic="3"
Const adLockReadOnly="1"

Dim objCn
Dim objRs
Dim objField

Dim strSql
Dim strHead
Dim strData

Set objCn = CreateObject("ADODB.Connection")
Set objRs = CreateObject("ADODB.Recordset")

objCn.Open "File Name=.\mydb.udl"

strSql = "select top 10 * from sample.csv;"

objRs.Open strSql, objCn, adOpenStatic, adLockReadOnly

strHead = ""
For Each objField In objRs.Fields
	strHead = strHead & objField.Name & vbTab
Next

WScript.Echo strHead
