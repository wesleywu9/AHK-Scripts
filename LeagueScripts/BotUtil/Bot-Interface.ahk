#Include BotUtil\ImageFinder.ahk
#Include BotUtil\BehaviorLib.ahk
#Include BotUtil\Settings.ahk

/*
-------------------------------
        Initialization
-------------------------------
*/

LoadScript()
;Constants
global CHAMP_NAME := ""
global MAX_ORDER := []
global CAST_ORDER := []
global ACTIVE_RANGE := 0 ** 2 ;squared to shortcut calculations

/*
-------------------------------
      Game & Client Loop
-------------------------------
*/

RunGame() {
	if (!WinActive("League of Legends (TM) Client")) { ;Run client when not ingame
		RunClient()
		return
	}

	;Shop phase
	if () {
		BuyRecommended()
		LevelUp(MAX_ORDER) 
	}

	;Combat
	if (EnemyPosXY := FindEnemyXY()) {
		Send {%CENTER_CAMERA% down}
		EnemyPosXY := FindEnemyXY()
		EnemyDistance := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
		if (EnemyDistance) {
			if (EnemyDistance < ACTIVE_RANGE) {
				
			}
		}
		Send {%CENTER_CAMERA% up}
	} else {
		
	} 

}

/*
-------------------------------
          Execution
-------------------------------
*/

RunTest() {
	
}

;testing
1::
RunTest() 
return

;run script
Home::
loop
	RunGame()
return
Del::ExitApp
End::Reload

