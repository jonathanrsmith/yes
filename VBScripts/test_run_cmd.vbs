Option Explicit

Dim oShell
Set oShell = WScript.CreateObject ("WScript.Shell")

oShell.run "taskkill /f /im excel.exe", 0, True