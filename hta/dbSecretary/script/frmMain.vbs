Option Explicit

'//*********************************************************
'//* @procedure cmdExecSqlCommand_Click
'//*********************************************************
Private Sub cmdExecSqlCommand_Click
	'-- var Object
	Dim objCn
	Dim objRs
	
	'-- var String
	Dim strConnStr
	Dim strSql

	strConnStr = getActiveConnectionString
	
	If strConnStr = "" Then
		Msgbox "connection ddl (udl-files/file-paths/connstr) not selected!!",vbCritical,"選択エラー"
		Exit Sub
	End If
	
	If f_txa_sql_command.value = "" Then
		Msgbox "type-in sql-command",vbCritical,"未入力エラー"
		Exit Sub
	End If
	
	Set objCn = CreateObject("ADODB.Connection")
	Set objRs = CreateObject("ADODB.Recordset")
	
	objCn.Open strConnStr
	
	strSql = f_txa_sql_command.value
	
	objRs.Open strSql, objCn, adOpenStatic, adLockReadOnly
	
	createTable_Basic objRs, "id_view_result", "id"
End Sub

'//*********************************************************
'//* @procedure cmdRegisterData_Click
'//*********************************************************
Private Sub cmdRegisterData_Click
	'-- var Object
	Dim objArgs
	
	objArgs = Array(g_strDataDir & f_ddl_file_paths.value,"qa.csv")

	showWindow_ModalDialog _
		"frmRegister.html", _
		objArgs, _
		1024, _
		400

	viewList_Click
End Sub

'//*********************************************************
'//* @function getActiveConnectionString
'//*********************************************************
Private Function getActiveConnectionString
	'-- var String
	Dim strConnStr
	
	strConnStr = ""
	If f_ddl_connstr_types.value <> "-" Then
		Select Case f_ddl_connstr_types.value
		  Case "csv"
			strConnStr = createConnectionStringCsv(f_ddl_excel_file_paths.value)
		  Case "excel"
			strConnStr = createConnectionStringExcel_NOHD(getFilePath_Excel(f_ddl_excel_file_paths.value))
'--		  Case "access"
'--			strConnStr = createConnectionStringAccess(f_ddl_excel_file_paths.value)
'--		  Case "sqlserver"
'--			strConnStr = createConnectionStringSqlServer f_ddl_excel_file_paths.value
'--		  Case "oracle"
'--			strConnStr = createConnectionStringOracle f_ddl_excel_file_paths.value
'--		  Case "mysql"
'--			strConnStr = createConnectionStringMySql f_ddl_excel_file_paths.value
'--		  Case "postgresql"
'--			strConnStr = createConnectionStringPostGreSql f_ddl_excel_file_paths.value
'--		  Case Else
'--			strConnStr = createConnectionStringSqlite f_ddl_excel_file_paths.value
		End Select		
	ElseIf f_ddl_udl_files.value <> "-" Then
		strConnStr = "File Name=../conf/" & f_ddl_udl_files.value
	ElseIf f_ddl_file_paths.value <> "-" Then
		strConnStr = createConnectionStringCsv(g_strDataDir & f_ddl_file_paths.value)
	End If
	
	getActiveConnectionString = strConnStr
End Function

'//*********************************************************
'//* @procedure cmdExecSqlCmdExcel_Click
'//*********************************************************
Private Sub cmdExecSqlCmdExcel_Click( _
	byval p_strDataType _
)
	'-- var Object
	Dim objArrs
	
	'-- var String
	Dim strSql
	Dim strExp
	
	If f_ddl_data_types.value = "-" Then Exit Sub
	
	If f_ddl_excel_file_paths.value = "-" Then Exit Sub
	
	objArrs = Split(p_strDataType, ",")

	strSql = getSqlCommand(SQL_ID_VIEW_LIST)
	
	strSql = Replace(strSql, "%1", objArrs(0))
	strSql = Replace(strSql, "%2", objArrs(1))
	f_txa_sql_command.value = Replace(strSql, "%3", objArrs(2))
	
	cmdExecSqlCommand_Click
End Sub

