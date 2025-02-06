Function clearFolder(folderPath)
Set fso = CreateObject("Scripting.FileSystemObject")
Set folder = fso.GetFolder(folderPath)

' delete all files in root folder
for each f in folder.Files
   On Error Resume Next
   name = f.name
   f.Delete True
   If Err Then
     WScript.Echo "Error deleting:" & Name & " - " & Err.Description
   Else
     WScript.Echo "Deleted:" & Name
   End If
   On Error GoTo 0
Next
End Function