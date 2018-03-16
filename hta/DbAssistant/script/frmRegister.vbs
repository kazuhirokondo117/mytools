Option Explicit

'//*********************************************************
'//* Global var definitiions
'//*********************************************************
'-- var String
Dim g_strDataDir
Dim g_strTableName

'//*********************************************************
'//* @procedure window_onload
'//*********************************************************
Private Sub window_onload
	'-- var Object
	Dim objArgs

	objArgs = window.dialogArguments
	
	g_strDataDir = objArgs(0)
	g_strTableName = objArgs(1)
'	g_strDataDir = "C:\Users\winridge\Documents\tools\hta\worktimes\data\csv"

	body_onload
End Sub

'//*********************************************************
'//* @procedure body_onload
'//*********************************************************
Private Sub body_onload
	f_item(2).value = formatdatetime(now,2)
End Sub

'//*********************************************************
'//* @procedure cmdRegister_Click
'//*********************************************************
Private Sub cmdRegister_Click
	'-- var Object
	Dim objCn
	Dim objRs
	Dim objField
	
	'-- var String
	Dim strConnStr
	Dim strSql
	
	'-- var Integer
	Dim i
	
	strConnStr = createConnectionStringCsv(g_strDataDir)
	
	Set objCn = CreateObject("ADODB.Connection")
	Set objRs = CreateObject("ADODB.Recordset")
	
	objCn.Open strConnStr
	
	strSql = "select max(id) as MAX_ID from " & g_strTableName & ";"
	
	objRs.Open strSql, objCn, adOpenStatic, adLockReadOnly
	
	f_item(0).value = objRs("MAX_ID") + 1
	
	objRs.Close
	
	strSql = "select top 1 * from " & g_strTableName & ";"
	
	objRs.Open strSql, objCn, adOpenStatic, adLockOptimistic

	objRs.AddNew
	
	i = 0
	
	For Each objField In objRs.Fields
		objField.value = f_item(i).value
		i = i + 1
	Next
	
	objRs.Update
	
	msgbox "ìoò^äÆóπÇµÇ‹ÇµÇΩÅB",vbInformation,"ìoò^"

	If IsObject(objRs) Then objRs.Close
	If IsObject(objCn) Then objCn.Close
	
	Set objRs = Nothing
	Set objCn = Nothing
End Sub
