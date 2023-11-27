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

/*
-------------------------------
      Game & Client Loop
-------------------------------
*/

RunGame() {
	if (!WinActive(GAME_PROCESS)) { ;Run client when not ingame
		RunClient()
		static loaded := false
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

	; check ally and enemy presence
	Send {%ALLY_MAIN%}
	AllyPosXY := FindAllyXY()
	EnemyPosXY := FindEnemyXY()
	if (AllyPosXY) {
		if (EnemyPosXY) {
			; Ally and Enemy present

		} else {
			; only Ally present
			FollowAlly(ALLY_MAIN, 250)
		}
	} else {
		if (EnemyPosXY) {
			; only Enemy present

		} else {
			; neither Ally nor Enemy present
			Send {%RECALL%}
			LevelUp(MAX_ORDER)
			Sleep 7000
			BuyRecommended()
			Sleep 5000
		}
	}
}

RunTest() {
	StartTime := A_TickCount

	PrintKeys()

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

