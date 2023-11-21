#SingleInstance, force
#NoEnv
#InstallKeybdHook
#UseHook
CoordMode Pixel Window
CoordMode Mouse Window
SendMode Event
SetBatchLines -1
SetMouseDelay 20
SetKeyDelay 50

;Psuedo Constants
global CLIENT_PROCESS := "ahk_exe LeagueClientUx.exe"
global GAME_PROCESS := "League of Legends (TM) Client"
global CHAMP_NAME := ""
global SCREEN_CENTER
global ATTACK_MOVE
global CENTER_CAMERA
global HOLD_TO_LEVEL
global ITEM_SLOTS_ARR
global SCROLL_CAM_ARR
global SELECT_ALLY_ARR
global SHOP
global SPELL_1
global SPELL_2
global SPELL_3
global SPELL_4
global SUM_1
global SUM_2

LoadScript() {
    ;A_ScriptDir MUST BE IN LEAGUE_SCRIPTS
    infile := FileOpen(A_ScriptDir "\config.cfg", "r")
    keys := StrSplit(infile.read(), "`n")
    infile.Close()

    i := 1
    ;Keys in lexical order
    ATTACK_MOVE := StrSplit(keys[i++], ":")[2]
    CENTER_CAMERA := StrSplit(keys[i++], ":")[2]
    HOLD_TO_LEVEL := StrSplit(keys[i++], ":")[2]
    ITEM_SLOTS_ARR := StrSplit(StrSplit(keys[i++], ":")[2], ",")
    SCROLL_CAM_ARR := StrSplit(StrSplit(keys[i++], ":")[2], ",")
    SELECT_ALLY_ARR := StrSplit(StrSplit(keys[i++], ":")[2], ",")
    SHOP := StrSplit(keys[i++], ":")[2]
    SPELL_1 := StrSplit(keys[i++], ":")[2]
    SPELL_2 := StrSplit(keys[i++], ":")[2]
    SPELL_3 := StrSplit(keys[i++], ":")[2]
    SPELL_4 := StrSplit(keys[i++], ":")[2]
    SUM_1 := StrSplit(keys[i++], ":")[2]
    SUM_2 := StrSplit(keys[i++], ":")[2]

    ;Metadata
    SCREEN_CENTER := [A_ScreenWidth/2, (A_ScreenHeight/2)-10]
}
