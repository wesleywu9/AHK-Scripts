#Include BotUtil\ClientManager.ahk
#Include BotUtil\ImageFinder.ahk
#Include BotUtil\ItemManager.ahk
#Include BotUtil\LevelManager.ahk
#Include BotUtil\Settings.ahk

;Constants
global CHAMP_NAME := "Yuumi"
global ITEM_LIST := ["guardian's amulet", "ionian boots of lucidity", "moonstone renewer", "staff of flowing water", "ardent censer", "redemption"]
global MAX_ORDER := ["r", "e", "w", "q"]
global ACTIVE_RANGE := 650
global CENTER_ALLY := F_KEYS_ARR[1]

;Globals
global _level := 1

RunGame() {
	if (!WinActive("League of Legends (TM) Client")) { ;Run client when not ingame
		RunClient()
		return
	}
	
	;Manages levels and items
	if (ImageFinder.HasLevelUp()) {
		LevelManager.LevelUp(_level, MAX_ORDER)
		ItemManager.Buy(ITEM_LIST)
	}

	;Attach
	AttachedPosXY := ImageFinder.FindAttachedAlly()
	Send {%CENTER_ALLY% down}
	if (!AttachedPosXY) {
		msgbox not attached
		if (allyPosX) { 
			Mousemove A_ScreenWidth/2,(A_ScreenHeight/2)-10
			Click Right
			Send {%SPELL_2%}
			Sleep 500
			
		}
	}
	
	;Combat
	EnemyPosXY := ImageFinder.FindEnemyXY()
	Mousemove EnemyPosXY[1], EnemyPosXY[2]
	EnemyDistance := sqrt((EnemyPosXY[2] - AttachedPosXY[2])**2 + (EnemyPosXY[1] - AttachedPosXY[1])**2)
	if (EnemyDistance < ACTIVE_RANGE) {
		Send {%SPELL_3%}{%SPELL_1%}{%SPELL_4%}
		Loop % ITEM_SLOTS_ARR.Length() {
			SlotKey := ITEM_LIST[A_Index]
			Send {%SlotKey%}
		}
	}
}

Numpad9::
;Check constants
msgbox % CHAMP_NAME
msgbox % ITEM_LIST[1]
msgbox % CENTER_CAMERA

return

Del::ExitApp
End::Reload