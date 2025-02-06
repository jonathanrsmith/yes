Function CreateFolder(folderPath)
    Dim fso, folder
    
    Set fso = CreateObject("Scripting.FileSystemObject")
   
    If fso.FolderExists(folderPath) Then
        CreateFolder = False
        Exit Function
    End If
    
    Set folder = fso.CreateFolder(folderPath)
    
    If fso.FolderExists(folderPath) Then
        CreateFolder = True
    Else
        CreateFolder = False
    End If
    
    Set folder = Nothing
    Set fso = Nothing
End Function

Call CreateFolder("h:\testingFC")