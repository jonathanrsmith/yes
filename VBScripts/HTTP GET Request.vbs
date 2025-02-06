Option Explicit

Function checkURL(url)
    Dim xmlHttp
    Set xmlHttp = CreateObject("MSXML2.ServerXMLHTTP")
    
    ' Set up HTTP request
    xmlHttp.Open "GET", url, False
    xmlHttp.setRequestHeader "User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)"
    
    ' Send the request
    On Error Resume Next
    xmlHttp.Send

	MsgBox(xmlHttp.Status)

End Function

'Call checkURL("https://www.google.com")
Call checkURL("https://taxpayers.as/")