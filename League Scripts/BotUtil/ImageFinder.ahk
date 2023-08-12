;A_ScriptDir MUST BE IN LEAGUE_SCRIPTS
SetWorkingDir % A_ScriptDir "\resources"

;Functions
Test() {
    msgbox % A_WorkingDir
    
    ImageSearch, testX, testY, 0,0,A_ScreenWidth,A_ScreenHeight, activeLock.PNG
        if !Errorlevel 
            Mousemove testX, testY
        else 
            return
}

FindRandomizerXY(){
    ImageSearch, randX, randY, 0,0,A_ScreenWidth,A_ScreenHeight, randomChamp.PNG
    if !ErrorLevel
        return [randX,randY]
}

FindPlayerXY(){
    ImageSearch, playerHealthX, playerHealthY, 0,0,A_ScreenWidth,A_ScreenHeight, *5 playerHealthBar.PNG
    if !ErrorLevel
        return [playerHealthX+.02*A_ScreenWidth,playerHealthY+.13*A_ScreenHeight]
}

FindAllyXY(){
    ImageSearch, allyHealthX, allyHealthY, 0,0,A_ScreenWidth,A_ScreenHeight,*5 allyHealthBar.PNG
    if !ErrorLevel
        return [allyHealthX+.02*A_ScreenWidth,allyHealthY+.13*A_ScreenHeight]
}

FindEnemyXY(){
    ImageSearch, enemyHealthX, enemyHealthY, 0,0,A_ScreenWidth,A_ScreenHeight, *5 enemyHealthBar.PNG	
    if !ErrorLevel
        return [enemyHealthX+.02*A_ScreenWidth,enemyHealthY+.13*A_ScreenHeight]
        
}

FindAttachedAlly(){
    ImageSearch, attachedHealthX, attachedHealthY, 0,0,A_ScreenWidth,A_ScreenHeight, attachedAlly.PNG
    if !ErrorLevel
        return [attachedHealthX+47,attachedHealthY+135]
}

IsShopPhase(){
    ImageSearch, isDeadX, isDeadY, 0,0,A_ScreenWidth,A_ScreenHeight, shop-phase.PNG
    if !ErrorLevel
        return True
}

IsDead(){
    ImageSearch, isDeadX, isDeadY, 0,0,A_ScreenWidth,A_ScreenHeight, *5 deathIndicator.PNG
    if !ErrorLevel
        return True
}

IsPlayer50(){
    ImageSearch, isPlayer50X, isPlayer50Y, 0,0,A_ScreenWidth,A_ScreenHeight, playerHealth50.PNG
        if !Errorlevel
            return True
}

IsEnemy50(){
    ImageSearch, isEnemy50X, isEnemy50Y, 0,0,A_ScreenWidth,A_ScreenHeight, enemyHealth50.PNG
        if !Errorlevel
            return True
}

IsAlly50(){
    ImageSearch, isAlly50X, isAlly50Y, 0,0,A_ScreenWidth,A_ScreenHeight, allyHealth50.PNG
        if !Errorlevel
            return True
}

IsPickingChamp(){
    ImageSearch, isPickingChampX, isPickingChampY, 0,0,A_ScreenWidth,A_ScreenHeight, inactiveLock.PNG
        if !Errorlevel
            return True
}

CanLockChamp(){
    ImageSearch, canLockChampX, canLockChampY, 0,0,A_ScreenWidth,A_ScreenHeight, activeLock.PNG
        if !Errorlevel
            return [canLockChampX, canLockChampY]
}

MatchFound(){
    ImageSearch, matchFoundX, matchFoundY, 0,0,A_ScreenWidth,A_ScreenHeight, matchFound.PNG
        if !Errorlevel
            return [matchFoundX, matchFoundY]
}

Surrender(){
    ImageSearch, surrenderX, surrenderY, 0,0,A_ScreenWidth,A_ScreenHeight, surrender.PNG
        if !Errorlevel 
            Click %surrenderX%, %surrenderY%
}

HasLevelUp(){
    ImageSearch, isLeveledUpX, isLeveledUpY, 0,0,A_ScreenWidth,A_ScreenHeight, *10 levelUp.PNG
    if !Errorlevel 
        return True
}

