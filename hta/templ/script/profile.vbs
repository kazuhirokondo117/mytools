Option Explicit

'//********************************************************
'//* Gloabl Constant definitions
'//********************************************************
Const SQL_ID_LIST_FILE_PATH = 2
Const SQL_ID_FILE_PATH_EXCEL = 2
Const SQL_ID_SQL_FILTER = 3
Const SQL_ID_GET_DATA_MS_DB = 4
Const SQL_ID_GET_DATA_NOT_MS_DB = 5

'//********************************************************
'//* Gloabl var definitions
'//********************************************************
'-- var Object
Dim g_objFso

'-- var String
Dim g_strAppHome
Dim g_strDataDir
Dim g_strDataHome

'//*********************************************************
'//* @procedure win_onload
'//*********************************************************
Private Sub window_onload
	'-- var String
	Dim strCmdLine
	window.resizeTo 1024, 768
	
	Set g_objFso = CreateObject("Scripting.FileSystemObject")
	
	strCmdLine = Replace(oHtaApp.CommandLine,"""","")
	
	g_strAppHome = g_objFso.GetParentFolderName(strCmdLine) & "\..\"
	
	g_strDataDir = g_strAppHome & "data\"
End Sub

'//*********************************************************
'//* @procedure getActiveConnection
'//*********************************************************
Private Function getActiveConnection( _
	byval p_strDbType _
	)
	'-- var String
	Dim strConnStr
	Dim strPath
	Dim strUser
	Dim strPassword
	

	'-- clear connectio string
	strConnStr = ""

	Select Case p_strDbType
		Case "udl"
			If f_ddl_udl_files.value <> "-" Then
				strConnStr = createConnectionStringUdl(f_ddl_udl_files.value)
			Else
				'--Msgbox "udl file not selected!!",vbCritical,"選択エラー"
			End If
		Case "csv"
			If f_ddl_file_paths.value <> "-" Then
				If InStr(f_ddl_file_paths.value, "\") Then
					strPath = f_ddl_file_paths.value
				Else
					strPath = g_strDataDir & f_ddl_file_paths.value
				End If
				g_strDataHome = strPath
				strConnStr = createConnectionStringCsv(strPath)
			Else
				'--Msgbox "file path not selected!!",vbCritical,"選択エラー"
			End If
		Case "excel"
			If f_file_path_excel.value <> "" Then
				strPath = f_file_path_excel.value
				strConnStr = createConnectionStringExcel(strPath)
			ElseIf f_excel_paths.value <> "-" Then
				strPath = getFilePath_Excel(f_excel_paths.value)
				strConnStr = createConnectionStringExcel(strPath)
			Else
				'--Msgbox "file-path not selected!!",vbCritical,"選択エラー"
			End If
		Case "firebird"
			If f_file_path_excel.value <> "" Then
				strPath = f_file_path_excel.value
				strUser=f_txt_user.value
				strPassword=f_txt_password.value
				strConnStr = createConnectionStringFirebird(strPath, strUser, strPassword)
			ElseIf f_excel_paths.value <> "-" Then
				strPath = getFilePath_Excel(f_excel_paths.value)
				strConnStr = createConnectionStringFirebird(strPath, strUser, strPassword)
			Else
				'--Msgbox "file-path not selected!!",vbCritical,"選択エラー"
			End If
		Case Else
				Msgbox "db type unknown!! [type=" & f_ddl_db_types.value & "]",vbCritical,"選択エラー"
	End Select

	getActiveConnection = strConnStr
End Function

