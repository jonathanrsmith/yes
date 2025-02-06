Function findLinksWord(strFilename, strExcelFilename)
	
	On Error Resume Next
	Set objWord = CreateObject("Word.Application")
	Set objExcel = CreateObject("Excel.Application")
	Set objDoc = objWord.Documents.Open(strFilename)
	Set objWorkbook = objExcel.Workbooks.Add
	Set objWorksheet = objWorkbook.Worksheets(1)
	intRow = 1
	For Each objLink In objDoc.Hyperlinks
		objWorksheet.Cells(1, 1).Value = "LinkID"
		objWorksheet.Cells(1, 2).Value = "Link Name"
		objWorksheet.Cells(1, 3).Value = "Link URL"
		objWorksheet.Cells(1, 4).Value = "Link Check"
		If InStr(objLink.Address, "http") = 1 Then
			objWorksheet.Cells(intRow, 1).Value = intRow
			If (objLink.TextToDisplay = " ") Or (objLink.TextToDisplay = "") Then 
				objWorksheet.Cells(intRow, 2).Value = "No Name"
			Else 
				objWorksheet.Cells(intRow, 2).Value = objLink.TextToDisplay
			End If
			objWorksheet.Cells(intRow, 3).Value = objLink.Address
			intRow = intRow + 1
        End If
	Next
	
	objWorkbook.SaveAs strExcelFilename
	objDoc.Close
	objWord.Quit
	objWorkbook.Close
	objExcel.Quit

End Function

Call findLinksWord("h:\PDDdfvdfv.docx", "h:\test.xlsx")