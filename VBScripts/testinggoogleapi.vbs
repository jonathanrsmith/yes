Function DownloadGoogleSheetAsExcel(sheetId, clientId, clientSecret, outputPath)
    Dim xmlhttp, response, url, accessToken, tokenUrl, tokenBody, tokenRequest, tokenResponse, tokenExpiration
    
    ' Step 1: Obtain an access token using OAuth2
    tokenUrl = "https://accounts.google.com/o/oauth2/v2/auth"
    tokenBody = "grant_type=client_credentials&client_id=" & clientId & "&client_secret=" & clientSecret
    Set xmlhttp = CreateObject("MSXML2.XMLHTTP")
    xmlhttp.Open "POST", tokenUrl, False
    xmlhttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    xmlhttp.Send tokenBody
    MsgBox(xmlhttp.responseText)
    If xmlhttp.Status = 200 Then
        Set tokenResponse = ParseJson(xmlhttp.responseText)
        accessToken = tokenResponse.access_token
        tokenExpiration = Now + (tokenResponse.expires_in / 86400)
    Else
        DownloadGoogleSheetAsExcel = False
        Exit Function
    End If
    
    Set xmlhttp = Nothing
    
    ' Step 2: Download the Google Sheet as an Excel file using the access token
    url = "https://www.googleapis.com/spreadsheet/" & sheetId & "/export?mimeType=application/vnd.openxmlformats-officedocument.spreadsheetml.sheet&access_token=" & accessToken
    
    Set xmlhttp = CreateObject("MSXML2.XMLHTTP")
    
    xmlhttp.Open "GET", url, False
    xmlhttp.Send
    
    If xmlhttp.Status = 200 Then
        Set response = CreateObject("ADODB.Stream")
        response.Type = 1 'binary
        response.Open
        response.Write xmlhttp.responseBody
        response.SaveToFile outputPath, 2 'overwrite
        response.Close
        Set response = Nothing
        DownloadGoogleSheetAsExcel = True
    Else
        DownloadGoogleSheetAsExcel = False
    End If
    
    Set xmlhttp = Nothing
End Function

Function ParseJson(jsonString)
	Dim xmlDoc, node
    Set xmlDoc = CreateObject("Microsoft.XMLDOM")
    xmlDoc.async = False
    xmlDoc.LoadXML jsonString
    Set node = xmlDoc.SelectSingleNode("/*")
	ParseJson = node.Text
End Function

Call DownloadGoogleSheetAsExcel("1uKGwjalkmuYebJ_JTWaXzSWRVrpgi4n-T4G9HSkjihI", "489765182425-kg2duc2o0cdrsnkj8ilsmtfp2s0i9ip7.apps.googleusercontent.com", "o7cdus9BVbYsr6R1lQipryhu", "H:\testing.xlsx")
