#Include BotUtil\ImageFinder.ahk
#Include BotUtil\BehaviorLib.ahk
#Include BotUtil\Settings.ahk

;Constants
LoadScript()
global CHAMP_NAME := ""
global ITEM_LIST := ["guardian's hammer", "lucidity", "divine sunderer", "ruined king", "zhonyas", "dead mans", "chemtank"]
global MAX_ORDER := ["r", "q", "w", "e"]
global ACTIVE_RANGE_SQR := 300 ** 2 ;for skipping unnecessary distance calculation 
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
		Buy(ITEM_LIST)
		Sleep 500
		LevelUp(MAX_ORDER) 
		Sleep 500
	}

	;Combat
	EnemyPosXY := FindEnemyXY()
	if (EnemyPosXY) {
		Send {%CENTER_CAMERA% down}
		EnemyDistance_SQR := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
		if (EnemyDistance_SQR < ACTIVE_RANGE_SQR) {
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
			FollowAlly()
		}
		Send {%CENTER_CAMERA% up}
	} else { 
		FollowAlly()
	}
}

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

