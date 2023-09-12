#Include BotUtil\ImageFinder.ahk
#Include BotUtil\PowerManager.ahk
#Include BotUtil\Settings.ahk

;Constants
LoadScript()
global CHAMP_NAME := ""
global ITEM_LIST := ["guardian's hammer", "lucidity", "divine sunderer", "ruined king", "zhonyas", "dead mans", "chemtank"]
global MAX_ORDER := ["r", "q", "w", "e"]
global ACTIVE_RANGE_SQR := 300 ** 2 ;for skipping unnecessary distance calculation 

RunGame() {
	if (!WinActive("League of Legends (TM) Client")) { ;Run client when not ingame
		RunClient()
		return
	}

	;Shop phase
	if (IsDead()) {
		Sleep 1000
		Buy(ITEM_LIST)
		Sleep 1000
		LevelUp(MAX_ORDER) 
		Sleep 1000
	}

	;Combat
	EnemyPosXY := FindEnemyXY()
	if (EnemyPosXY) {
		Mousemove EnemyPosXY[1], EnemyPosXY[2]
		Click Right
		Send {%CENTER_CAMERA% down}
		EnemyDistance_SQR := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
		if (EnemyDistance_SQR < ACTIVE_RANGE_SQR) {
			
			Send {%SPELL_4%}{%SPELL_1%}{%SPELL_2%}{%SPELL_3%}{%SUM_1%}{%SUM_2%}{%ATTACK_MOVE%}
			Loop % ITEM_SLOTS_ARR.Length() {
				SlotKey := ITEM_SLOTS_ARR[A_Index]
				Send {%SlotKey%}
			}
		}
		Send {%CENTER_CAMERA% up}
	} else { 
		;follow an ally
		Ally1 := SELECT_ALLY_ARR[1]
		Send {%Ally1% down}
		Click, Right
		
		Random, RandKey, 1, SCROLL_CAM_ARR.Length()
		Key := SCROLL_CAM_ARR[RandKey]
		Send {%Key% down}
		Sleep 200
		Send {%Key% up}
		Send {%CENTER_CAMERA% down}
		Send {%CENTER_CAMERA% up}

		Send {%Ally1% up}
	}
}

RunTest() {

	Test()

}

;testing
Numpad9::
RunTest()
return

;run script
Home::
loop
	RunGame()
return
Del::ExitApp
End::Reload

