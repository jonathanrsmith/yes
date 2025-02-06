Function IsURLValid(url, username, password)
     On Error Resume Next

     Dim http
     'Set http = CreateObject("MSXML2.ServerXMLHTTP")
     Set http = CreateObject("Msxml2.XMLHTTP.6.0")
     ' Open a connection to the URL and send a GET request
     http.Open "GET", url, False
     http.SetRequestHeader "User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36", "Authorization", "Basic " & Base64Encode(username & ":" & password)
     http.Send

     ' Check the status code of the response
     If Err.Number = 0 Then
         If http.Status = 200 Then
             IsURLValid = True
         Else
             IsURLValid = False
             WScript.Echo "Status code: " & http.Status
         End If
     Else
         IsURLValid = False
         WScript.Echo "An error occurred while checking the URL." & http.Status
     End If

     ' Clean up
     Set http = Nothing
     On Error GoTo 0
End Function

Function Base64Encode(input)
     Dim objXML, objNode
     Set objXML = CreateObject("MSXML2.DOMDocument")
     Set objNode = objXML.createElement("base64")
     objNode.DataType = "bin.base64"
     objNode.Text = Stream_StringToBinary(input)
     Base64Encode = objNode.Text
     Set objNode = Nothing
     Set objXML = Nothing
End Function

Function Stream_StringToBinary(s)
     Dim stream, binary
     Set stream = CreateObject("ADODB.Stream")
     stream.Type = 2 ' adTypeText
     stream.Charset = "us-ascii"
     stream.Open
     stream.WriteText s
     stream.Position = 0
     stream.Type = 1 ' adTypeBinary
     stream.Position = 0
     binary = stream.Read
     Stream_StringToBinary = binary
     stream.Close
     Set stream = Nothing
End Function

' Example usage
Dim urlToCheck, username, password
urlToCheck = "https://insite.gsa.gov/directives-library/budget-administration-handbook-42514b-cfo?term=CFO%204251.4B"
username = "jonathanrsmith"
password = "Impressing8468#$"
If IsURLValid(urlToCheck, username, password) Then
     WScript.Echo urlToCheck & " is a valid URL."
Else
     WScript.Echo urlToCheck & " is not a valid URL."
End If