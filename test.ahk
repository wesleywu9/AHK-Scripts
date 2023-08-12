#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

string := "1:a"
Numpad9::
arr := StrSplit(string, ":")

return
