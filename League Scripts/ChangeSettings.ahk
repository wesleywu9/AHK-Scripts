﻿#SingleInstance, force
Gui, Font, s15
controlDict := {"Spell1":"q","Spell2":"w","Spell3":"e","Spell4":"r","Sum1":"d","Sum2":"f","AttackMove":"a","HoldToLevel":"ctrl","Shop":"p","Items":"1,2,3,5,6,7","F_keys":"F1,F2,F3,F4,F5","CenterCamera":"space"}
defaultDict := controlDict.Clone()
path := A_ScriptDir "\config.cfg"
infile := FileOpen(path, "r")
for control, key in controlDict {
    string := StrSplit(infile.ReadLine(), ":")[2]
    string := StrSplit(string, "`n")[1]
    controlDict[control] := string
    Gui add, text, r1 w300, % control
    Gui add, edit, r1 w120 lowercase vEdit%A_Index%, % string
}
infile.Close()
Gui add, button, r1 gDefault, Default
Gui add, button, r1 gSave, Save
Gui show, , Settings
return

GuiClose:
ExitApp
return

Default:
for control, key in defaultDict {
    GuiControl Text, Edit%A_Index%, % key 
}
return

Save:
Gui Submit
infile := FileOpen(path, "w")
infile.Write("")
for control, key in controlDict {
    currentInput := "Edit" . A_Index
    currentInput := RTrim(%currentInput%, OmitChars = ["`r`n"," ", "`r", "`n"])
    writeLine := Format("{1}:{2}", control, currentInput)
    infile.WriteLine(writeLine)
}
infile.Close()
return

