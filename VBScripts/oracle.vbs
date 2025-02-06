Dim conn, rs

' Database connection information
Dim strHost, strIP, strUsername, strPassword, strServiceName
strHost = "B04TCM-ORAPRD02.ent.ds.gsa.gov"
strIP = "1521"
strUsername = "NPEPD_FDPYEoMRptng"
strPassword = "MAY12_END"
strServiceName = "fpay.world"

' SQL query to run
Dim strSQL
strSQL = "SELECT * FROM your_table_name"

' Create a connection object
Set conn = CreateObject("ADODB.Connection")

' Construct the connection string
Dim strConn
strConn = "Provider=System.Data.OracleClient;Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=" & strHost & ")(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=" & strServiceName & ")(SID=" & strServiceName & "))); User ID=" & strUsername & ";Password=" & strPassword & ""

' Open the connection
conn.Open strConn

' Create a recordset object
Set rs = CreateObject("ADODB.Recordset")

' Execute the SQL query
rs.Open strSQL, conn

recordCount = rs.Fields("RecordCount").Value

If recordCount > 0 Then
    MsgBox "Yes, data exists.", vbInformation, "Data Check"
Else
    MsgBox "No, data does not exist.", vbExclamation, "Data Check"
End If

' Close the recordset and connection
rs.Close
conn.Close

' Clean up objects
Set rs = Nothing
Set conn = Nothing