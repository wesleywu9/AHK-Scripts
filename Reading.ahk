#SingleInstance, force
#UseHook
#InstallKeybdHook

infScroll := 50

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
4::
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
5::
readDuration := 6500
loop {
sleep readDuration
Send {Right}
}
return

;manhwa

1::
Click, middle
sleep 50
Mousemove, 0, infScroll, 0, R
return

;Jump up
2::
offset := 175+infScroll
Mousemove 0, -offset, 0, R
Sleep 350
Mousemove 0, offset, 0, R
return

;Jump down
3::
offset := 125
Mousemove 0, offset, 0, R
Sleep 350
Mousemove 0, -offset, 0, R
return
