#Include BotUtil\ImageFinder.ahk
#Include BotUtil\PowerManager.ahk
#Include BotUtil\Settings.ahk

;Constants
LoadScript()
global CHAMP_NAME := ""
global ITEM_LIST := ["guardian's horn", "lucidity", "locket", "zhonyas", "sunfire", "randuin", "chemtank"]
global MAX_ORDER := ["r", "q", "w", "e"]
global ACTIVE_RANGE_SQR := 625 ** 2 ;for skipping unnecessary distance calculation 

RunGame() {
	if (!WinActive("League of Legends (TM) Client")) { ;Run client when not ingame
		RunClient()
		return
	}

	;Look for gameover
	ExitArena()

	;Shop phase
	if (IsShopPhase()) {
		Send {%SHOP%}
		Buy(ITEM_LIST)
		Sleep 1000
		LevelUp(MAX_ORDER) 
		Sleep 8000
	}

	;Combat
	EnemyPosXY := FindEnemyXY()
	if (EnemyPosXY) {
		Mousemove EnemyPosXY[1], EnemyPosXY[2]
		Click Right
		EnemyDistance_SQR := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
		if (EnemyDistance_SQR < ACTIVE_RANGE_SQR) {
			Send {%SPELL_4%}{%SPELL_1%}{%SPELL_2%}{%SPELL_3%}{%SUM_1%}{%SUM_2%}{%ATTACK_MOVE%}
			Sleep 100
			Loop % ITEM_SLOTS_ARR.Length() {
				SlotKey := ITEM_SLOTS_ARR[A_Index]
				Send {%SlotKey%}
			}
		}
	} else { 
		;Find enemy
		Random, rx, 0, A_ScreenWidth
		Random, ry, 0, A_ScreenHeight
		Mousemove rx, ry 
		Sleep 1000
		Click Right
		Send {%CENTER_CAMERA% down}
		Send {%CENTER_CAMERA% up}
	}
}

RunTest() {
	
	if(IsPickingChamp())
		msgbox true
		
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