﻿#Include BotUtil\ImageFinder.ahk
#Include BotUtil\BehaviorLib.ahk
#Include BotUtil\Settings.ahk

/*
-------------------------------
        Initialization
-------------------------------
*/

LoadScript()
;Constants
global MAX_ORDER := []
global CAST_ORDER := []
global ACTIVE_RANGE := 0

/*
-------------------------------
      Game & Client Loop
-------------------------------
*/

RunGame() {
	if (!WinActive(GAME_PROCESS)) { ;Run client when not ingame
		RunClient("")
		return
	}

	; Shop/level
	if () {
		BuyRecommended()
		LevelUp(MAX_ORDER) 
	}

	; look for enemy
	if (EnemyPosXY := FindEnemyXY()) {
		; check proximity
		Send {%CENTER_CAMERA% down}
		if (EnemyPosXY := FindEnemyXY()) {
			EnemyDistance := GetDistance(SCREEN_CENTER, EnemyPosXY)
			if (EnemyDistance < ACTIVE_RANGE) {
				
			}
		}
		Send {%CENTER_CAMERA% up} 
	} else if (AllyPosXY := FindAllyXY()) { ; look for ally
		
	} else { ; no enemy or ally
		
	}

}

/*
-------------------------------
          Execution
-------------------------------
*/

RunTest() {
	StartTime := A_TickCount


	
	;MsgBox % A_TickCount - StartTime " milliseconds have elapsed."
}

;testing
Ins::
RunTest() 
return

;run script
Home::
loop
	RunGame()
return
Del::ExitApp
End::Reload

