Function formatExcel(excelFile)
Dim objXLA
	Set objXLA = CreateObject("Excel.Application")
	Set objWorkbook = objXLA.Workbooks.Open(excelFile)
	objXLA.Application.DisplayAlerts = False
	
	objXLA.Range("A1:A1").Select
	objXLA.Selection.ColumnWidth = 10
		
	objXLA.Range("B1:B1").Select
	objXLA.Selection.ColumnWidth = 45
	objXLA.Selection.HorizontalAlignment = -4131
	
	objXLA.Range("C1:C1").Select
	objXLA.Selection.ColumnWidth = 65
	objXLA.Selection.HorizontalAlignment = -4131
	
	objXLA.Range("D1:D1").Select
	objXLA.Selection.ColumnWidth = 25
	
	objXLA.Range("E1:E1").Select
	objXLA.Selection.ColumnWidth = 15
	
	objXLA.Range("A1:A1000").Select
	objXLA.Selection.HorizontalAlignment = &HFFFFEFF4
	objXLA.Range("D1:D1000").Select
	objXLA.Selection.HorizontalAlignment = &HFFFFEFF4
	objXLA.Range("E1:E1000").Select
	objXLA.Selection.HorizontalAlignment = &HFFFFEFF4
	
	objXLA.Range("A1:E1").Select
	objXLA.Selection.Font.Name = "Arial"
	objXLA.Selection.Font.Size = 12
	objXLA.Selection.Font.Bold = True
	objXLA.Selection.HorizontalAlignment = &HFFFFEFF4
	objXLA.Selection.Interior.ColorIndex = 15
	'objXLA.Selection.NumberFormat = "@"
	objXLA.Selection.RowHeight = 16
	objXLA.Selection.Borders.LineStyle = 1
	
	objWorkbook.Save
	objWorkbook.Close
	objXLA.Quit
End Function

call formatExcel("H:\stuff\Final Reports\RPA Development Best Practices and Technical Configuration Guide_ WORKING DRAFT - Link Report.xlsx")