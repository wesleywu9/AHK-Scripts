#Include BotUtil\ImageFinder.ahk
#Include BotUtil\PowerManager.ahk
#Include BotUtil\Settings.ahk

;Constants
LoadScript()
global CHAMP_NAME := "Yuumi"
global ITEM_LIST := ["guardian's amulet", "echoes of helia", "imperial mandate", "ardent censer", "staff of flowing water", "redemption"]
global MAX_ORDER := ["r", "e", "w", "q"]
global ACTIVE_RANGE_SQR := 625 ** 2 ;for skipping unnecessary distance calculation 

;Globals
global _attached := false
RunGame() {
	if (!WinActive("League of Legends (TM) Client")) { ;Run client when not ingame
		RunClient()
		return
	}

	;Manages shop phase
	if (HasLevelUp()) {
		_attached := false
		Sleep 5000
		Mousemove SCREEN_CENTER[1], SCREEN_CENTER[2]
		Click left
		Send {%SHOP%}
		Buy(ITEM_LIST)
		Sleep 1000
		while (HasLevelUp()) {
			LevelUp(MAX_ORDER) 
			Sleep 500
		}
		Sleep 6000
	}

	AllyPosXY := FindAllyXY()
	;Not attached
	if (_attached == false) {
		;attempt to attach
		Mousemove AllyPosXY[1], AllyPosXY[2]
		Send {%SPELL_2%}
		Sleep 1000
	} else {
		EnemyPosXY := FindEnemyXY()
		if (EnemyPosXY != NULL) {
			Send {%CENTER_CAMERA% down}
			Send {%CENTER_CAMERA% up}
			EnemyDistance_SQR := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
			if (EnemyDistance_SQR < ACTIVE_RANGE_SQR) {
				Mousemove EnemyPosXY[1], EnemyPosXY[2]
				Send {%SPELL_3%}{%SPELL_1%}{%SPELL_4%}{%SUM_1%}{%SUM_2%}{%ATTACK_MOVE%}
				Loop % ITEM_SLOTS_ARR.Length() {
					SlotKey := ITEM_LIST[A_Index]
					Send {%SlotKey%}
				}
			}
			Sleep 500
		}
	}

	if(AllyPosXY == NULL) {
		_attached == true
	}
}

RunTest() {
	
	AllyPosXY := FindEnemyXY()
	Mousemove AllyPosXY[1], AllyPosXY[2]
		
}

Numpad9::
loop
	RunGame()
return

Numpad8::
RunTest()
return

Del::ExitApp
End::Reload