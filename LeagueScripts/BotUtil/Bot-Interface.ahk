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
global MAX_ORDER := []
global CAST_ORDER := []
global ACTIVE_RANGE := 0 ** 2 ;squared to shortcut calculations

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

