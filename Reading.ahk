#SingleInstance, force
#UseHook
#InstallKeybdHook

infScroll := 60

Del::exitapp
End::reload

;RPGM
!z::
Loop {
    Send {z down}
    Sleep 1
    Send {z up}
    Sleep 5000
}
return

;doujin
Numpad6::
scrollSpeed := 70
scrollDuration := 5500
readDuration := 1600
loop {
sleep readDuration
Click, middle
Mousemove, 0, scrollSpeed, 0, R
sleep scrollDuration
Click
Mousemove, 0, -scrollSpeed, 0, R
sleep readDuration/2
Send {Right}
}
return

;simple turn
Numpad3::
readDuration := 6500
loop {
sleep readDuration
Send {Right}
}
return

;manhwa

Numpad9::
Click, middle
sleep 50
Mousemove, 0, infScroll, 0, R
return

;Jump up
Numpad7::
offset := 175+infScroll
Mousemove 0, -offset, 0, R
Sleep 350
Mousemove 0, offset, 0, R
return

;Jump down
Numpad8::
offset := 125
Mousemove 0, offset, 0, R
Sleep 350
Mousemove 0, -offset, 0, R
return
