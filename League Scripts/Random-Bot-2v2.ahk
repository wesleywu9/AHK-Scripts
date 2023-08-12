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

	;Exit game
	Mousemove 1150, 470
	Click left

	;Shop phase
	if (IsShopPhase()) {
		Sleep 5000
		Mousemove SCREEN_CENTER[1], SCREEN_CENTER[2]
		Click left
		Sleep 5000
		Send {%SHOP%}
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
		EnemyDistance_SQR := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
		if (EnemyDistance_SQR < ACTIVE_RANGE_SQR) {
			Send {%SPELL_4%}{%SPELL_1%}{%SPELL_2%}{%SPELL_3%}{%SUM_1%}{%SUM_2%}{%ATTACK_MOVE%}
			Loop % ITEM_SLOTS_ARR.Length() {
				SlotKey := ITEM_LIST[A_Index]
				Send {%SlotKey%}
			}
		}
	} else { 
		;Find enemy
		Random, rx, 0, A_ScreenWidth
		Random, ry, 0, A_ScreenHeight
		Mousemove rx, ry 
		Click Right
		Send {%CENTER_CAMERA% down}
		Send {%CENTER_CAMERA% up}
	}
}

RunTest() {
	
	if (IsShopPhase())
		msgbox True
	else
		msgbox false
		
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