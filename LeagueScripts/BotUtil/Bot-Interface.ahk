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

	; Check ally and enemy presence
	Send {%ALLY_MAIN%}
	AllyPosXY := FindAllyXY()
	EnemyPosXY := FindEnemyXY()
	if (AllyPosXY) {
		if (EnemyPosXY) {
			; Ally and Enemy present

		} else {
			; only Ally present
			
		}
	} else {
		if (EnemyPosXY) {
			; only Enemy present

		} else {
			; neither Ally nor Enemy present
			
		}
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

