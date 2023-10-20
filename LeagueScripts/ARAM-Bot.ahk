#Include BotUtil\ImageFinder.ahk
#Include BotUtil\BehaviorLib.ahk
#Include BotUtil\Settings.ahk

;Constants
LoadScript()
global CHAMP_NAME := ""
global MAX_ORDER := ["r", "q", "w", "e"]
global ACTIVE_RANGESQR := 300 ** 2 ;for skipping unnecessary distance calculation 
global ALLY1 := SELECT_ALLY_ARR[1]

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
	EnemyPosXY := FindEnemyXY()
	if (EnemyPosXY) {
		Send {%CENTER_CAMERA% down}
		EnemyDistanceSQR := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
		if (EnemyDistanceSQR < ACTIVE_RANGESQR) {
			Mousemove EnemyPosXY[1], EnemyPosXY[2]
			Click Right
			Sleep 100
			Send {%SPELL_4%}{%SPELL_1%}{%SPELL_2%}{%SPELL_3%}{%SUM_1%}{%SUM_2%}{%ATTACK_MOVE%}
			Sleep 50
			Loop % ITEM_SLOTS_ARR.Length() {
				SlotKey := ITEM_SLOTS_ARR[A_Index]
				Send {%SlotKey%}
			}
		} else {
			FollowRandom()
		}
		Send {%CENTER_CAMERA% up}
	} else { 
		FollowRandom()
	}
}

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

