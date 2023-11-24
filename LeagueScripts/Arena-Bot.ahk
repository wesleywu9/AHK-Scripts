#Include BotUtil\ImageFinder.ahk
#Include BotUtil\BehaviorLib.ahk
#Include BotUtil\Settings.ahk

;Constants
LoadScript()
global CHAMP_NAME := ""
global MAX_ORDER := ["r", "q", "w", "e"]
global CAST_ORDER := [SPELL_4, SPELL_3, SPELL_2, SPELL_1, SUM_1, SUM_2, ATTACK_MOVE]
global ACTIVE_RANGE_SQR := 615 ** 2 ;for skipping unnecessary distance calculation 

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
		Mousemove EnemyPosXY[1], EnemyPosXY[2]
		Click Right
		Send {%CENTER_CAMERA% down}
		EnemyPosXY := FindEnemyXY()
		EnemyDistance_SQR := (EnemyPosXY[2] - SCREEN_CENTER[2])**2 + (EnemyPosXY[1] - SCREEN_CENTER[1])**2
		if (EnemyDistance_SQR && EnemyDistance_SQR < ACTIVE_RANGE_SQR) {
			loop % CAST_ORDER.Length() {
				EnemyPosXY := FindEnemyXY()
				Mousemove EnemyPosXY[1], EnemyPosXY[2]
				ability := CAST_ORDER[A_Index]
				Send % ability
				Sleep 10
			}
			Loop % ITEM_SLOTS_ARR.Length() {
				SlotKey := ITEM_SLOTS_ARR[A_Index]
				Send {%SlotKey%}
			}
			MoveChampRandom(SCREEN_CENTER[1], SCREEN_CENTER[2], 100)
		}
		Send {%CENTER_CAMERA% up}
	} else if (AllyPosXY := FindAllyXY()) {
		MoveChampRandom(AllyPosXY[1], AllyPosXY[2], 100)
		xKey := (AllyPosXY[1] < SCREEN_CENTER[1]) ? SCROLL_CAM_ARR[3] : SCROLL_CAM_ARR[4]
		yKey := (AllyPosXY[2] < SCREEN_CENTER[2]) ? SCROLL_CAM_ARR[1] : SCROLL_CAM_ARR[2]
		Send {%xKey% down}
		Send {%yKey% down}
		Sleep 250
		Send {%xKey% up}
		Send {%yKey% up}
		MoveChampRandom(SCREEN_CENTER[1], SCREEN_CENTER[2], 100)
	} else { 
		;Pan screen randomly
		Random, RandKey, 1, SCROLL_CAM_ARR.Length()
		Key := SCROLL_CAM_ARR[RandKey]
		Send {%Key% down}
		Sleep 250
		Send {%Key% up}
		Mousemove SCREEN_CENTER[1], SCREEN_CENTER[2]
		Click Right
	}
*/
	
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

