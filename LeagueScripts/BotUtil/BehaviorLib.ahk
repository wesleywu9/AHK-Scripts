#Include BotUtil\ImageFinder.ahk
#Include BotUtil\Settings.ahk

/*-------------------------------
            Client
-------------------------------*/

;accepts queue and picks champ
RunClient() {
    if IsPickingChamp() {
        while (IsPickingChamp() == True) {
            MousePercentMove(60,14)
            Click left
            Send % CHAMP_NAME
            Sleep 500
            MousePercentMove(30,22)
            Click left
            Sleep 500
            MousePercentMove(50,85)
            Click Left
            Sleep 500
            MousePercentMove(60,14)
            Click left
            Sleep 500
            Send ^a{Delete}
            Sleep 500
        }
    } else {
        MousePercentMove(44,95)
        Click left
        MousePercentMove(50,78)
        Click left
        Sleep 1000
    }
}

;move mouse % window distance
MousePercentMove(xPercent, yPercent) {
    WinGetPos, X, Y, W, H, %CLIENT_PROCESS%
    xFlat := W*1/100*xPercent
    yFlat := H*1/100*yPercent
    Mousemove xFlat, yFlat
}

/*-------------------------------
            Ingame
-------------------------------*/

;move mouse % window distance from current pos
MouseRelativeMove(xPercent, yPercent) {
    xFlat := A_ScreenWidth*1/100*xPercent
    yFlat := A_ScreenHeight*1/100*yPercent
    Mousemove xFlat, yFlat,,R
}

;move mouse randomly some offset away from (x,y)
MoveMouseRandom(x, y, offset) {
    Random, RandX, x-offset, x+offset
    Random, RandY, y-offset, y+offset
    Mousemove RandX, RandY
}

;pan camera some distance toward (x,y)
PanCameraToward(x, y) {
    xKey := (x < SCREEN_CENTER[1]) ? SCROLL_CAM_ARR[3] : SCROLL_CAM_ARR[4]
	yKey := (y < SCREEN_CENTER[2]) ? SCROLL_CAM_ARR[1] : SCROLL_CAM_ARR[2]
    Send {%xKey% down}
    Send {%yKey% down}
    Sleep 250
    Send {%xKey% up}
    Send {%yKey% up}
}

;follow ally based on SelectAlly key
FollowAlly(ally) {
    Send {%ally%}
    Random, randX, -300, 300
    Random, randY, -300, 300
    Mousemove SCREEN_CENTER[1], SCREEN_CENTER[2]
    Mousemove %randX%, %randY%, , R
    Click Right
}

;level all four abilities
LevelUp(ByRef ORDER) {
    Send {%HOLD_TO_LEVEL% down}
    Send % order[1]
    Send % order[2]
    Send % order[3]
    Send % order[4]
    Send {%HOLD_TO_LEVEL% up}
    Sleep 500
}

;buy all of a given list of items
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

;buy the middle recommended item
BuyRecommended() {
    Send {%SHOP%}
    Sleep 500
    ShopIcon := ShopOpen()
    Mousemove ShopIcon[1], ShopIcon[2]
    MouseRelativeMove(0, -5)
    Click left
    Sleep 500
    Mousemove ShopIcon[1], ShopIcon[2]
    MouseRelativeMove(15, 15)
    Click Right
    Sleep 500
    Send {%SHOP%}
}

;attack enemy based on cast order
AttackEnemy(ByRef CAST_ORDER) {
    loop % CAST_ORDER.Length() {
        EnemyPosXY := FindEnemyXY()
        Mousemove EnemyPosXY[1], EnemyPosXY[2]
        ability := CAST_ORDER[A_Index]
        Send % ability
        Send {%ATTACK_MOVE%}
        Sleep 10
    }
    Loop % ITEM_SLOTS_ARR.Length() {
        SlotKey := ITEM_SLOTS_ARR[A_Index]
        Send {%SlotKey%}
    }
}