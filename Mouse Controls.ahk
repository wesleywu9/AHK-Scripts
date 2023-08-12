#SingleInstance, force
#NoEnv
#InstallKeybdHook
#UseHook
CoordMode Pixel Window
CoordMode Mouse Window
SendMode Event
SetBatchLines -1
SetMouseDelay 20
SetKeyDelay 0
SetControlDelay 0
Del::exitapp
End::reload

Numpad9::
;Clicks constantly
loop {
Click
Sleep 100
}
Return

Numpad6::
;Holds down click
WinGet, WinInfo, ProcessName, A
MouseGetPos, myX, myY
ControlClick, , ahk_exe %WinInfo%, , L, , NA D
Click down
Return

Numpad3::
;Testing
Click down
loop {
Click right
Sleep 135
}

