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
global MAX_ORDER := ["r", "q", "w", "e"]
global CAST_ORDER := [SPELL_4, SPELL_3, SPELL_2, SPELL_1, SUM_1, SUM_2]
global ACTIVE_RANGE := 300 ** 2 ;squared to shortcut calculations
global loaded := false

/*
-------------------------------
      Game & Client Loop
-------------------------------
*/

RunGame() {
	if (!WinActive(GAME_PROCESS)) { ;Run client when not ingame
		RunClient()
		loaded := false
		return
	} else if (loaded == false) {
		while(!FindPlayerXY()) {
			Sleep 1000
		}
		loaded := True
		BuyRecommended()
		LevelUpSingle(MAX_ORDER[4])
	}	

	;Shop phase
	if (IsDead()) {
		BuyRecommended()
		LevelUp(MAX_ORDER) 
	}

	;Combat
	if (EnemyPosXY := FindEnemyXY()) {
		Mousemove EnemyPosXY[1], EnemyPosXY[2]
		Click Right
		Send {%CENTER_CAMERA% down}
		EnemyPosXY := FindEnemyXY()
		EnemyDistance := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
		;attack enemy when in range
		if (EnemyDistance) {
			if (EnemyDistance < ACTIVE_RANGE) {
				AttackEnemy(CAST_ORDER)
				MoveMouseRandom(SCREEN_CENTER[1], SCREEN_CENTER[2], 100)
				Click Right
			}
		}
		Send {%CENTER_CAMERA% up}
	} else { ;follow random ally
		Random, num, 1, 4
		randomAlly := SELECT_ALLY_ARR[num]
		FollowAlly(randomAlly)
		MoveMouseRandom(SCREEN_CENTER[1], SCREEN_CENTER[2], 100)
		Click Right
	} 

}

/*
-------------------------------
          Execution
-------------------------------
*/

RunTest() {
	LevelUp(MAX_ORDER[4])
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

