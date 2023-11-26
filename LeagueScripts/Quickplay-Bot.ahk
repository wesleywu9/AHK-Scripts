#Include BotUtil\ImageFinder.ahk
#Include BotUtil\BehaviorLib.ahk
#Include BotUtil\Settings.ahk

/*-------------------------------
         Initialization
-------------------------------*/

LoadScript()
;Constants
global MAX_ORDER := ["r", "q", "w", "e"]
global CAST_ORDER := [SPELL_4, SPELL_3, SPELL_2, SPELL_1]
global ACTIVE_RANGESQR := 600 ** 2
global DANGER_RANGESQR := 250 ** 2
global ALLY_MAIN := SELECT_ALLY_ARR[1] ;should be bot lane ally

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
		;check enemy distance
		Send {%CENTER_CAMERA% down}
		EnemyDistanceSQR := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
		if (EnemyDistanceSQR < ACTIVE_RANGESQR) {
			AttackEnemy(CAST_ORDER)
			Mousemove A_ScreenWidth-EnemyPosXY[1], A_ScreenHeight-EnemyPosXY[2]
			MouseGetPos, xMouse, yMouse
			MoveMouseRandom(xMouse, yMouse, 100)
			Click Right
		}
		Send {%CENTER_CAMERA% up}
	} else { ;follow bot lane ally when no enemy
		FollowAlly(ALLY_MAIN)
		MoveMouseRandom(SCREEN_CENTER[1], SCREEN_CENTER[2], 100)
		Click Right
	}
}

RunTest() {
	EnemyPosXY := FindEnemyXY()
	Mousemove A_ScreenWidth-EnemyPosXY[1], A_ScreenHeight-EnemyPosXY[2]
}

/*-------------------------------
            Execution
-------------------------------*/

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

