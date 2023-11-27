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
global CAST_ORDER := [SPELL_4, SPELL_3, SPELL_2, SPELL_1]
global ACTIVE_RANGE := 650 ** 2 ;squared to shortcut calculations
global DANGER_RANGE := 350 ** 2 ;squared to shortcut calculations
global ALLY_MAIN := SELECT_ALLY_ARR[4] ;should be bot lane ally
global loaded := false

/*
-------------------------------
      Game & Client Loop
-------------------------------
*/

RunGame() {
	if (!WinActive("League of Legends (TM) Client")) { ;Run client when not ingame
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

	;Look for gameover
	ExitArena()

	;Shop phase
	if (IsDead()) {
		BuyRecommended()
		LevelUp(MAX_ORDER) 
	}

	;Combat
	if (EnemyPosXY := FindEnemyXY()) {
		;check enemy distance
		Send {%CENTER_CAMERA% down}
		Sleep 10
		EnemyPosXY := FindEnemyXY()
		if (EnemyPosXY) { 
			EnemyDistance := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
			awayX := SCREEN_CENTER[1] + ((SCREEN_CENTER[1]-EnemyPosXY[1]) << 3)
			awayY := SCREEN_CENTER[2] + ((SCREEN_CENTER[2]-EnemyPosXY[2]) << 3)
			if (EnemyDistance < DANGER_RANGE) {
				Mousemove awayX, awayY
				Click Right
				Send {%SUM_1%}{%SUM_2%}
			} else if (EnemyDistance < ACTIVE_RANGE) {
				AttackEnemy(CAST_ORDER)
				Mousemove awayX, awayY
				Click Right
				Sleep 200
			}
		}
		Send {%CENTER_CAMERA% up}
	} else { ;follow bot lane ally when no enemy
		FollowAlly(ALLY_MAIN)
		MoveMouseRandom(SCREEN_CENTER[1], SCREEN_CENTER[2], 200)
		Click Right
		Sleep 400
	}
	;always auto+kite
	MoveMouseRandom(SCREEN_CENTER[1], SCREEN_CENTER[2], 100)
	Send {%ATTACK_MOVE%}
	Sleep 250
	Click Right
}

RunTest() {
	StartTime := A_TickCount

	

	;MsgBox % A_TickCount - StartTime " milliseconds have elapsed."
}

/*
-------------------------------
          Execution
-------------------------------
*/

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

