;A_ScriptDir MUST BE IN LEAGUE_SCRIPTS
SetWorkingDir % A_ScriptDir "\resources"

;Functions
Test() {
    msgbox % A_WorkingDir

}

FindPlayerXY(){
    ImageSearch, playerHealthX, playerHealthY, 0,0,A_ScreenWidth,A_ScreenHeight, *5 player-health.PNG
    if !ErrorLevel
        return [playerHealthX+.02*A_ScreenWidth,playerHealthY+.13*A_ScreenHeight]
}

FindAllyXY(){
    ImageSearch, allyHealthX, allyHealthY, 0,0,A_ScreenWidth,A_ScreenHeight,*5 ally-health.PNG
    if !ErrorLevel
        return [allyHealthX+.02*A_ScreenWidth,allyHealthY+.13*A_ScreenHeight]
}

FindEnemyXY(){
    ImageSearch, enemyHealthX, enemyHealthY, 0,0,A_ScreenWidth,A_ScreenHeight, *5 enemy-health.PNG	
    if !ErrorLevel
        return [enemyHealthX+.02*A_ScreenWidth,enemyHealthY+.13*A_ScreenHeight]
        
}

IsShopPhase(){
    ImageSearch, isDeadX, isDeadY, 0,0,A_ScreenWidth,A_ScreenHeight, shop-phase.PNG
    if !ErrorLevel
        return True
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

MatchFound(){
    ImageSearch, matchFoundX, matchFoundY, 0,0,A_ScreenWidth,A_ScreenHeight, match-found.PNG
        if !Errorlevel
            return [matchFoundX, matchFoundY]
}

Surrender(){
    ImageSearch, surrenderX, surrenderY, 0,0,A_ScreenWidth,A_ScreenHeight, surrender.PNG
        if !Errorlevel 
            Click %surrenderX%, %surrenderY%
}

HasLevelUp(){
    ImageSearch, isLeveledUpX, isLeveledUpY, 0,0,A_ScreenWidth,A_ScreenHeight, *10 level-up.PNG
    if !Errorlevel 
        return True
}

