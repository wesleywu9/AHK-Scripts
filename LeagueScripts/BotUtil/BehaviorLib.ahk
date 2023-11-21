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
            Mousemove 960, 130
            Click left
            Send % CHAMP_NAME
            Sleep 500
            Mousemove 480, 200
            Click left
            Sleep 500
            Mousemove 800, 760
            Click Left
            Sleep 500
            Mousemove 960, 130
            Click left
            Sleep 500
            Send ^a{Delete}
            Sleep 500
        }
    } else {
        Mousemove 730, 850
        Click left
        Mousemove 800, 700
        Click left
        Sleep 1000
    }
}

MoveClientPercent() {
    xFlat := A_ScreenWidth*1/100*xPercent
    yFlat := A_ScreenHeight*1/100*yPercent
    Mousemove xFlat, yFlat,,R
}

MoveRelativePercent(xPercent, yPercent) {
    xFlat := A_ScreenWidth*1/100*xPercent
    yFlat := A_ScreenHeight*1/100*yPercent
    Mousemove xFlat, yFlat,,R
}