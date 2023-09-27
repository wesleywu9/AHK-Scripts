#Include BotUtil\ImageFinder.ahk
#Include BotUtil\Settings.ahk

;Follows ally

FollowAllies() {
    Random, AllyNum, 1, 4
    ally := SELECT_ALLY_ARR[AllyNum]
    Send {%ally%}
    Random, randX, -300, 300
    Random, randY, -300, 300
    Mousemove SCREEN_CENTER[1], SCREEN_CENTER[2]
    Mousemove %randX%, %randY%, , R
    Click Right
}

;Tries to level all four abilities
LevelUp(ByRef ORDER) {
    Send {%HOLD_TO_LEVEL% down}
    Send % order[1]
    Send % order[2]
    Send % order[3]
    Send % order[4]
    Send {%HOLD_TO_LEVEL% up}
    Sleep 500
}

;Tries to buy a given list of items in order
BuyList(ByRef ITEM_LIST) {
    Send {%SHOP%}
    Sleep 500
    Loop % ITEM_LIST.Length() {
        Send ^l
        Sleep 200
        Send % ITEM_LIST[A_Index]
        Sleep 500
        Send {Enter}
        Sleep 200
    }
    Send {%SHOP%}
}

BuySuggested() {
    Send {%SHOP%}
    Sleep 500
    ShopIcon := ShopOpen()
    Mousemove ShopIcon[1]+20, ShopIcon[2]-80
    Click left
    Mousemove ShopIcon[1]+200, ShopIcon[2]+200
    Click Right
    Sleep 500
    Send {%SHOP%}
}