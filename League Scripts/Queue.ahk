#Include BotUtil\ImageFinder.ahk
#Include BotUtil\Settings.ahk
#SingleInstance, force

loop {
	if(WinExist("League of Legends (TM) Client")) {
		Sleep 20000
	}
	else {
		matchFound := ImageFinder.MatchFound()
        if matchFound {
            Mousemove matchFound[1], matchFound[2]
            Click Left
            MouseMove 0, 0
        }
		sleep 1000
	}
}
Return

Del::exitapp
