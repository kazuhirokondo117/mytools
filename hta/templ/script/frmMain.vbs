Option Explicit

'//*********************************************************
'//* @procedure cmdExecSqlCommand_Click
'//*********************************************************
Private Sub cmdExecSqlCommand_Click( _
	byval p_strSqlType _
	)
	'-- var Object
	Dim objCn
	Dim objRs
	Dim objValues
	
	'-- var String
	Dim strConnStr
	Dim strSql
	Dim strPath
	
	'-- var Integer
	Dim intRecNum
	
	'-- Is db type selected
	If f_ddl_db_types.value = "-" Then Exit Sub
	
	objValues = Split(f_ddl_db_types.value, ",")

	strConnStr = getActiveConnection(objValues(0))

	If strConnStr = "" Then Exit Sub

	If f_txa_sql_command.value = "" Then
		Msgbox "sql command nothing!!",vbCritical,"ñ¢ì¸óÕÉGÉâÅ["
		Exit Sub
	End If
	
	Set objCn = CreateObject("ADODB.Connection")
	Set objRs = CreateObject("ADODB.Recordset")
	
	objCn.Open strConnStr
	
	strSql = f_txa_sql_command.value
	
	If p_strSqlType = "query" Then
		objRs.Open strSql, objCn, adOpenStatic, adLockReadOnly
	Else
		objCn.Execute strSql,intRecNum
		If intRecNum Then Msgbox "command successfully!!", vbInformation:Exit Sub
	End If
	
	createTable_Basic objRs, "id_view_result", "id"
	
	If IsObject(objRs) Then objRs.Close
	If IsObject(objCn) Then objCn.Close
	
	Set objRs = Nothing
	Set objCn = Nothing
End Sub

'//*********************************************************
'//* @procedure cmdViewSchemaInfo_Click
'//*********************************************************
Private Sub cmdViewSchemaInfo_Click( _
	byref p_objSchemaTypes, _
	byref p_objSchemaTypeFilter _
	)
	'-- var Object
	Dim objCn
	Dim objRs
	Dim objValues
	
	'-- var String
	Dim strConnStr
	Dim strSql
	
	'-- var Integer
	
	'-- Is schema type selected
	If p_objSchemaTypes.value = "-" Then Exit Sub
	
	'-- Is tables selected
	If f_ddl_tables.value = "-" Then Exit Sub
	
	objValues = Split(f_ddl_db_types.value, ",")

	strConnStr = getActiveConnection(objValues(0))

	If strConnStr = "" Then Exit Sub
	
	objValues = Split(p_objSchemaTypes.value, ",")

	Set objCn = CreateObject("ADODB.Connection")
	Set objRs = CreateObject("ADODB.Recordset")
	
	objCn.Open strConnStr
	
	Set objRs = getSchemaInfo(objCn, objValues(0))
	
	'-- is schema type filter not null
'--	If p_objSchemaTypeFilter.value <> "" Then
'--		strSql = objValues(1) & " like '%" & p_objSchemaTypeFilter.value & "%'"
'--		objRs.Find strSql
'--	Else
		strSql = objValues(1) & " = '" & f_ddl_tables.value & "'"
		objRs.Find strSql
'--	End If
'--	objRs.Find "TABLE_NAME like '%sample%'"
	
	createTable_Basic objRs, "id_view_result", "id"
	
	If IsObject(objRs) Then objRs.Close
	If IsObject(objCn) Then objCn.Close
	
	Set objRs = Nothing
	Set objCn = Nothing
End Sub

