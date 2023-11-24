#Include BotUtil\ImageFinder.ahk
#Include BotUtil\Settings.ahk

;Follow ally
FollowAlly(ally) {
    Send {%ally%}
    Random, randX, -300, 300
    Random, randY, -300, 300
    Mousemove SCREEN_CENTER[1], SCREEN_CENTER[2]
    Mousemove %randX%, %randY%, , R
    Click Right
}

;Follows random ally
FollowRandom() {
    Random, AllyNum, 1, 4
    ally := SELECT_ALLY_ARR[AllyNum]
    FollowAlly(ally)
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

;Buys the middle recommended item
BuyRecommended() {
    Send {%SHOP%}
    Sleep 500
    ShopIcon := ShopOpen()
    Mousemove ShopIcon[1], ShopIcon[2]
    MoveRelativePercent(0, -5)
    Click left
    Sleep 500
    Mousemove ShopIcon[1], ShopIcon[2]
    MoveRelativePercent(15, 15)
    Click Right
    Sleep 500
    Send {%SHOP%}
}

;accepts queue and picks champ
RunClient() {
    if IsPickingChamp() {
        while (IsPickingChamp() == True) {
            MoveClientPercent(60,14)
            Click left
            Send % CHAMP_NAME
            Sleep 500
            MoveClientPercent(30,22)
            Click left
            Sleep 500
            MoveClientPercent(50,85)
            Click Left
            Sleep 500
            MoveClientPercent(60,14)
            Click left
            Sleep 500
            Send ^a{Delete}
            Sleep 500
        }
    } else {
        MoveClientPercent(44,95)
        Click left
        MoveClientPercent(50,78)
        Click left
        Sleep 1000
    }
}

MoveChampRandom(x, y, offset) {
    Random, RandX, x-offset, x+offset
    Random, RandY, y-offset, y+offset
    Mousemove RandX, RandY
    Click Right
}

MoveClientPercent(xPercent, yPercent) {
    WinGetPos, X, Y, W, H, %CLIENT_PROCESS%
    xFlat := W*1/100*xPercent
    yFlat := H*1/100*yPercent
    Mousemove xFlat, yFlat
}

MoveRelativePercent(xPercent, yPercent) {
    xFlat := A_ScreenWidth*1/100*xPercent
    yFlat := A_ScreenHeight*1/100*yPercent
    Mousemove xFlat, yFlat,,R
}