Function TakeScreenshot(url, filename)
    Set objShell = CreateObject("WScript.Shell")
    Set objChrome = CreateObject("Shell.Application")
    objShell.Run "chrome.exe " & url
    Set objWindow = objChrome.Windows().Item(0)
	objWindow.Visible = True
    'objWindow.Navigate(url)
    WScript.Sleep 100
	objWindow.SendKeys "{prtsc}"
	objWindow.Quit
End Function	
	
Call TakeScreenshot("https://ears.ocfo.gsa.gov/ears/faces/home.jsp", "h:\scrncap.png")