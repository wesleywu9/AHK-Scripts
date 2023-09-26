;A_ScriptDir MUST BE IN LEAGUE_SCRIPTS
SetWorkingDir % A_ScriptDir "\resources"

;Functions
Test() {
    ImageSearch, playerHealthX, playerHealthY, 0,0,A_ScreenWidth,A_ScreenHeight, *10 death-indicator.PNG
    if !ErrorLevel
        msgbox found image!

}

FindPlayerXY(){
    ImageSearch, playerHealthX, playerHealthY, 0,0,A_ScreenWidth,A_ScreenHeight, *10 player-health.PNG
    if !ErrorLevel
        return [playerHealthX+.02*A_ScreenWidth,playerHealthY+.13*A_ScreenHeight]
}

FindAllyXY(){
    ImageSearch, allyHealthX, allyHealthY, 0,0,A_ScreenWidth,A_ScreenHeight, *10 ally-health.PNG
    if !ErrorLevel
        return [allyHealthX+.02*A_ScreenWidth,allyHealthY+.13*A_ScreenHeight]
}

FindEnemyXY(){
    ImageSearch, enemyHealthX, enemyHealthY, 0,0,A_ScreenWidth,A_ScreenHeight, *10 enemy-health.PNG	
    if !ErrorLevel
        return [enemyHealthX+.02*A_ScreenWidth,enemyHealthY+.13*A_ScreenHeight]
        
}

ShopOpen(){
    ImageSearch, shopX, shopY, 0,0,A_ScreenWidth,A_ScreenHeight, *10 shop-search.PNG
    if !ErrorLevel
        return [shopX, shopY]
}

ExitArena(){
    ImageSearch, ExitArenaX, ExitArenaY, 0,0,A_ScreenWidth,A_ScreenHeight, *10 arena-exit.PNG
    if !ErrorLevel
        Click %ExitArenaX%, %ExitArenaY%
}

IsDead(){
    ImageSearch, isDeadX, isDeadY, 0,0,A_ScreenWidth,A_ScreenHeight, *5 death-indicator.PNG
    if !ErrorLevel
        return True
}

IsPickingChamp(){
    ImageSearch, isPickingChampX, isPickingChampY, 0,0,A_ScreenWidth,A_ScreenHeight, inactive-lock.PNG
        if !Errorlevel
            return True
}

AcceptQueue(){
    ImageSearch, AcceptQueueX, AcceptQueueY, 0,0,A_ScreenWidth,A_ScreenHeight, match-found.PNG
        if !Errorlevel {
            Click %AcceptQueueX%, %AcceptQueueY%
            Mousemove 0,0
        }
}

Surrender(){
    ImageSearch, SurrenderX, SurrenderY, 0,0,A_ScreenWidth,A_ScreenHeight, surrender.PNG
        if !Errorlevel 
            Click %SurrenderX%, %SurrenderY%
}


