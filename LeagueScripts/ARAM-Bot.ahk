#Include Settings.ahk

class AramBot {
	champName := ""
	retreatRange := 250
	attackRange := 600
	allyNum := 1

	load() {
		LevelManager := new LevelManager([spell4, spell1, spell2, spell3])
		ItemManager := new ItemManager(["guardians horn", "locket", "warmogs", "redemption", "steelcaps", "gargoyle"])
		ItemManager.buy()
	}

	play() {
		;Checking for unexpected
		ImageFinder.surrender()

		;Locates entities
		playerPosX := ImageFinder.findPlayerXY()[1], playerPosY := ImageFinder.findPlayerXY()[2]
		allyPosX := ImageFinder.findAllyXY()[1], allyPosY := ImageFinder.findAllyXY()[2]
		enemyPosX := ImageFinder.findEnemyXY()[1], enemyPosY := ImageFinder.findEnemyXY()[2]
		playerEnemyDistance := sqrt((playerPosY - enemyPosY)**2 + (playerPosX - enemyPosX)**2)
		playerAllyDistance := sqrt((playerPosY - allyPosY)**2 + (playerPosX - allyPosX)**2)
		enemyAllyDistance := sqrt((enemyPosY - allyPosY)**2 + (enemyPosX - allyPosX)**2)
		Random RNG, -100, 100

		;player safety
		if (ImageFinder.isPlayer50() || !allyPosX) {
			Mousemove playerPosX + (playerPosX - enemyPosX), playerPosY + (playerPosY - enemyPosY)
			Click Right
			if (enemyPosX && playerEnemyDistance < this.retreatRange) {
				if (ImageFinder.isPlayer50()) {
					Mousemove playerPosX + (playerPosX - enemyPosX)*100, playerPosY + (playerPosY - enemyPosY)*100
					Click Right
					Send {%sum1%}{%sum2%}
					Sleep 1000
				}		
			}
		}

		;player aggression
		if (allyPosX && enemyPosX && playerPosX && playerEnemyDistance < this.attackRange) { 
			Mousemove enemyPosX, enemyPosY
			Send {%spell4%}
			Send {%spell1%}
			Send {%spell2%}
			Send {%spell3%}
			Send {%attackMove%}
			Sleep 50
			Mousemove allyPosX, allyPosY
			Send {%spell4%}
			Send {%spell1%}
			Send {%spell2%}
			Send {%spell3%}
			Loop % itemSlots.Length() {
				i += 1
				item := itemSlots[i]
				Send {%item%}
			}
		}

		;follows ally
		currentAlly := fKeys[this.allyNum]
		Send {%currentAlly% down}
		Mousemove RNG+A_ScreenWidth/2, RNG+A_ScreenHeight/2
		Click right
		Sleep 100
		Send {%currentAlly% up}
		if (!allyPosX && !enemyPosX) {
			this.allyNum += 1
			if (this.allyNum > fKeys.Length()) 
				this.allyNum := 1
		}

		;items/levels
		if (ImageFinder.isLeveling()) 
			LevelManager.levelUp()	
		if (!playerPosX)
			if (ImageFinder.isDead())
				test := ItemManager.buy()
	}
}

Numpad9::
msgbox Bot active
game := new GameManager(new AramBot())
game.run()
return

Del::ExitApp
End::Reload