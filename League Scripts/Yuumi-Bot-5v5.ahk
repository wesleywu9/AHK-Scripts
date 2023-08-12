#Include Settings.ahk

class YuumiBot {
	champName := "Yuumi"
	retreatRange := 400
	attackRange := 650
	allyNum := 1

	load() {
		LevelManager := new LevelManager([spell4, spell3, spell1, spell2])
		ItemManager := new ItemManager(["spellthief", "forbidden", "forbidden", "forbidden", "staff of flow", "ardent", "redemption", "mikaels"])
		ItemManager.buy()
	}

	play() {
		;Locates Entities
		playerPosXY := ImageFinder.FindPlayerXY()
		allyPosXY := ImageFinder.FindAllyXY()
		enemyPosXY := ImageFinder.FindEnemyXY()
		attachedPosXY := ImageFinder.FindAttachedAlly()
		playerEnemyDistance := sqrt((playerPosY - enemyPosY)**2 + (playerPosX - enemyPosX)**2)
		playerAllyDistance := sqrt((playerPosY - allyPosY)**2 + (playerPosX - allyPosX)**2)
		enemyAllyDistance := sqrt((enemyPosY - allyPosY)**2 + (enemyPosX - allyPosX)**2)
		enemyAttachedDistance := sqrt((enemyPosY - attachedPosY)**2 + (enemyPosX - attachedPosX)**2)

		;Finds and attaches to ally
		currentAlly := fKeys[allyNum]
		Send {%currentAlly% down}
		if (!attachedPosX) {
			if (allyPosX) { 
				Mousemove A_ScreenWidth/2,(A_ScreenHeight/2)-10
				Click Right
				Send {%spell2%}
				Sleep 500
				
			}
		}

		;Handles combat
		if (attachedPosX) {
			Mousemove enemyPosX, enemyPosY
			if (ImageFinder.isAlly50()) {
				Send {%spell3%}
				if (enemyPosX && enemyAttachedDistance <= retreatRange)
					Send {%sum1%}{%sum2%}
			}
			if (enemyAttachedDistance <= attackRange) {
				Send {%spell1%}{%spell4%}
				Loop % itemSlots.Length() {
					Mousemove enemyPosX, enemyPosY
					i += 1
					item := itemSlots[i]
					Send {%item%}
					Sleep 1
				}
			}
		}
		
		;Manages items/levels
		if (ImageFinder.isLeveledUp()) 
			LevelManager.levelUp()	
		if (!playerPosX)
			if (ImageFinder.isDead()) 
				ItemManager.buy()
		Sleep 20
		Send {%currentAlly% up}
	}
}

Numpad9::
msgbox Bot active
game := new GameManager(new YuumiBot())
game.run()
return

Del::ExitApp
End::Reload