Option Explicit
'//********************************************************
'//* Gloabl Constant definitions
'//********************************************************
Const SQL_ID_VIEW_LIST = 3
Const SQL_ID_LIST_FILE_PATH = 1
Const SQL_ID_FILE_PATH_EXCEL = 2
'//********************************************************
'//* Gloabl var definitions
'//********************************************************
'-- var Object
Dim g_objFso

'-- var String
Dim g_strAppHome
Dim g_strDataDir

'//*********************************************************
'//* @procedure window_onload
'//*********************************************************
Private Sub window_onload
	'-- var String
	Dim strCmdLine
	window.resizeTo 1800, 768
	
	Set g_objFso = CreateObject("Scripting.FileSystemObject")
	
	strCmdLine = Replace(oHtaApp.CommandLine,"""","")
	
	g_strAppHome = g_objFso.GetParentFolderName(strCmdLine) & "\..\"
	
	g_strDataDir = g_strAppHome & "data\"
	
	createDDL_ExcelFilePaths
	body_onload
End Sub

'//*********************************************************
'//* @procedure body_onload
'//*********************************************************
Private Sub body_onload
	viewList_Click
End Sub

'//*********************************************************
'//* @procedure viewList_Click
'//*********************************************************
Private Sub viewList_Click()
'--	If f_ddl_connstr_types.value <> "-" Then Exit Sub
'--	f_ddl_file_paths.value = "csv"
'--	f_txa_sql_command.value = "select top 10 * from qa.csv;"
'--	cmdExecSqlCommand_Click
	f_ddl_connstr_types.value = "excel"
'--	f_ddl_excel_file_paths.value = "˜AŒg—pŒÚ‹qŠî–{"
	f_ddl_excel_file_paths.Options(1).selected = true
'--	cmdExecSqlCmdExcel_Click
End Sub

'//*********************************************************
'//* @procedure createDDL_ExcelFilePaths
'//*********************************************************
Private Sub createDDL_ExcelFilePaths
	'-- var Object
	Dim objCn
	Dim objRs
	
	'-- var String
	Dim strConnStr
	Dim strSql
	Dim strHtml

	Set objCn = CreateObject("ADODB.Connection")
	Set objRs = CreateObject("ADODB.Recordset")
	
	strConnStr = createConnectionStringCsv(g_strDataDir&"csv")
	
	objCn.Open strConnStr
	
	strSql = getSqlCommand(SQL_ID_LIST_FILE_PATH)
	
	objRs.Open strSql, objCn, adOpenStatic, adLockReadOnly
	
	strHtml = "<select name=""f_ddl_excel_file_paths"" onchange="""">" & vbCrLf
	
	strHtml = strHtml & _
		"<option value=""-"">-- excel-file-paths --</option>" & vbCrLf
	Do Until objRs.EOF
		strHtml = strHtml & _
			"<option value=""" & objRs("key_") & """ selected=""true"">" & objRs("value_") & "</option>" & vbCrLf
		objRs.MoveNext
	Loop

	strHtml = strHtml & _
		"</select>" & vbCrLf
	
	document.getElementById("id_excel_file_path").innerHTML = strHtml
	
	If IsObject(objRs) Then objRs.Close
	If IsObject(objCn) Then objCn.Close
	
	Set objRs = Nothing
	set objCn = Nothing
End Sub

