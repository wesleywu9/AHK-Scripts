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
global ACTIVE_RANGE_SQR := 615 ** 2

/*-------------------------------
        Game & Client Loop
-------------------------------*/

RunGame() {
	if (!WinActive(GAME_PROCESS)) { ;Run client when not ingame
		RunClient()
		return
	}

	;Look for gameover
	ExitArena()

	;Shop phase
	if (ShopOpen()) {
			Sleep 1000
			Send {%SHOP%}
			Sleep 1000
			loop 2 {
				BuyRecommended()
				Sleep 1000
				LevelUp(MAX_ORDER) 
				Sleep 1000
			}
	}

	;Combat
	if (EnemyPosXY := FindEnemyXY()) { 
		;move toward enemy if seen
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
	} else if (AllyPosXY := FindAllyXY()) { ;pan and move toward ally
		PanCameraToward(AllyPosXY[1], AllyPosXY[2])
		MoveMouseRandom(AllyPosXY[1], AllyPosXY[2], 200)
		Click Right
	} else { ;pan screen randomly
		Random, RandKey, 1, SCROLL_CAM_ARR.Length()
		Key := SCROLL_CAM_ARR[RandKey]
		Send {%Key% down}
		Sleep 250
		Send {%Key% up}
		Mousemove SCREEN_CENTER[1], SCREEN_CENTER[2]
		Click Right
	}
}

/*-------------------------------
            Execution
-------------------------------*/

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

