#Include BotUtil\ImageFinder.ahk
#Include BotUtil\BehaviorLib.ahk
#Include BotUtil\Settings.ahk

/*-------------------------------
         Initialization
-------------------------------*/

LoadScript()
;Constants
global MAX_ORDER := ["r", "q", "w", "e"]
global CAST_ORDER := [SPELL_4, SPELL_3, SPELL_2, SPELL_1, SUM_1, SUM_2]
global ACTIVE_RANGESQR := 300 ** 2

/*-------------------------------
        Game & Client Loop
-------------------------------*/

RunGame() {
	if (!WinActive("League of Legends (TM) Client")) { ;Run client when not ingame
		RunClient()
		return
	}

	;Randomness to avoid detection
	Random, timer, 0, 10
	Sleep timer

	;Shop phase
	if (IsDead()) {
		BuyRecommended()
		Sleep 500
		LevelUp(MAX_ORDER) 
		Sleep 500
	}

	;Combat
	if (EnemyPosXY := FindEnemyXY()) {
		Mousemove EnemyPosXY[1], EnemyPosXY[2]
		Click Right
		Send {%CENTER_CAMERA% down}
		EnemyPosXY := FindEnemyXY()
		EnemyDistance_SQR := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
		;attack enemy when in range
		if (EnemyDistance_SQR && EnemyDistance_SQR < ACTIVE_RANGE_SQR) {
			AttackEnemy(CAST_ORDER)
			MoveMouseRandom(SCREEN_CENTER[1], SCREEN_CENTER[2], 100)
			Click Right
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

/*-------------------------------
            Execution
-------------------------------*/

RunTest() {
	BuyRecommended()
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

