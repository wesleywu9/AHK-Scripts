#Include BotUtil\ImageFinder.ahk
#Include BotUtil\Settings.ahk

LevelUp(ByRef ORDER) {
    Send {%HOLD_TO_LEVEL% down}
    Send % order[1]
    Send % order[2]
    Send % order[3]
    Send % order[4]
    Send {%HOLD_TO_LEVEL% up}
    Sleep 500
}

Buy(ByRef ITEM_LIST) {
    Send {%SHOP%}
    Sleep 200
    Loop % ITEM_LIST.Length() {
        Send ^l
        Sleep 200
        Send % ITEM_LIST[A_Index]
        Sleep 200
        Send {Enter}
        Sleep 200
    }
    Send {%SHOP%}
    return bought
}
