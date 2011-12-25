#NoEnv
#InstallKeybdHook
SetKeyDelay, 100, 30
SetWorkingDir, C:\Users\Jon\Documents\Code\progress_engine ;put script and other files here

;delays should be increased for slower computers, ideally all parameterized to one variable
;# = windows key; press it with whatever letter to start that function

#p::Pause ;useful to stop all that clicking when you're done

#b::
PlayNGames(1)
return


SetPushMasteries()
{
MouseClick, left,  970,  63
Sleep, 4000
MouseClick, left,  758,  185
Sleep, 4000
MouseClick, left,  362,  221
Sleep, 2000
MouseClick, left,  283,  264
Sleep, 1000
Send, super{SPACE}push{ENTER}
MouseClick, left,  279,  400
Sleep, 300
MouseClick, left,  462,  270
Sleep, 300
MouseClick, left,  462,  270
Sleep, 300
MouseClick, left,  462,  270
Sleep, 300
MouseClick, left,  575,  278
Sleep, 300
MouseClick, left,  571,  352
Sleep, 300
MouseClick, left,  460,  358
Sleep, 300
MouseClick, left,  460,  358
Sleep, 300
MouseClick, left,  460,  358
Sleep, 300
MouseClick, left,  460,  358
Sleep, 300
MouseClick, left,  456,  430
Sleep, 300
MouseClick, left,  400,  429
Sleep, 300
MouseClick, left,  783,  279
Sleep, 300
MouseClick, left,  783,  279
Sleep, 300
MouseClick, left,  783,  279
Sleep, 300
MouseClick, left,  852,  279
Sleep, 300
MouseClick, left,  852,  279
Sleep, 300
MouseClick, left,  675,  284
Sleep, 300
MouseClick, left,  728,  350
Sleep, 300
MouseClick, left,  728,  350
Sleep, 300
MouseClick, left,  673,  425
Sleep, 300
MouseClick, left,  673,  425
Sleep, 300
MouseClick, left,  859,  430
Sleep, 300
MouseClick, left,  724,  359
Sleep, 300
MouseClick, left,  662,  503
Sleep, 300
MouseClick, left,  935,  271
Sleep, 300
MouseClick, left,  993,  272
Sleep, 300
MouseClick, left,  993,  272
Sleep, 300
MouseClick, left,  993,  272
Sleep, 300
MouseClick, left,  726,  358
Sleep, 300
MouseClick, left,  727,  423
Sleep, 300
MouseClick, left,  274,  379
Sleep, 300


return
}

BetterShop(ByRef lastElixir) ;for 1280x800, upper left hand corner of shop should be put @ ~210, 126
{
Send {p} ;open shop
Sleep, 500
if (DontHaveItem("wriggles.bmp"))
{
	Send {Click 257, 269} ;click on home button
	Sleep, 1000
	Send {Click 420, 381} ;click on attack items
	Sleep, 1000
	Send {Click 420, 317} ;click on damage
	Sleep, 1000
	Send {Click 329, 469} ;click on wriggles
	Sleep, 50
	Send {Click 329, 469} ;double click to buy
}
Sleep, 1000
if (DontHaveItem("wriggles.bmp")) ;still no wriggles?
{
	if (DontHaveItem("razors.bmp"))	
	{
		Send {Click 302, 392} ;click on razors
		Sleep, 50
		Send {Click 302, 392} ;double click to buy
	}
	Sleep, 1000
	if (DontHaveItem("razors.bmp")) ;still no razors?
	{
		if (DontHaveItem("longsword.bmp"))
		{
			Send {Click 499, 307} ;click on longsword
			Sleep, 50
			Send {Click 499, 307} ;double click to buy
		}
	}
}
Sleep, 1000
if (DontHaveItem("tiamat.bmp"))
{
	Send {Click 257, 269} ;click on home button
	Sleep, 1000
	Send {Click 420, 381} ;click on attack items
	Sleep, 1000
	Send {Click 420, 317} ;click on damage
	Sleep, 1000
	Send {Click 351, 540} ;click on tiamat
	Sleep, 50
	Send {Click 351, 540} ;double click to buy
}
Sleep, 1000
if (DontHaveItem("tiamat.bmp")) ;still no tiamat?
{
	if (DontHaveItem("pickaxe.bmp"))
	{
		Send {Click 515, 348} ;click on pickaxe
		Sleep, 50
		Send {Click 515, 348} ;double click to buy
	}
}

if (DontHaveItem("tiamat.bmp") OR DontHaveItem("wriggles.bmp"))
{
	Send {Esc} ;close shop
	Sleep, 500
	return ;save money if we don't have core items
}
else
{		
	Send {Click 257, 269} ;click on home button
	Sleep, 1000
	Send {Click 440, 566} ;click on consumables
	Sleep, 1000
	if (lastElixir = "red")
	{
		lastElixir := "green"
		Send {Click 509, 388} ;click on green pot
		Sleep, 50
		Send {Click 509, 388} ;buy green pot
		Sleep, 500
		Send {Click 377, 388} ;click on red pot
		Sleep, 50
		Send {Click 377, 388} ;buy red pot
		Sleep, 500
	}
	else
	{
		lastElixir := "red"
		Send {Click 377, 388} ;click on red pot
		Sleep, 50
		Send {Click 377, 388} ;buy red pot
		Sleep, 500
		Send {Click 509, 388} ;click on green pot
		Sleep, 50
		Send {Click 509, 388} ;buy green pot
		Sleep, 500
	}

	Send {Esc} ;close shop
	Sleep, 500
	Send {1} ;spam all item actives to eat elixirs
	Sleep, 100
	Send {2} 
	Sleep, 100
	Send {3} 
	Sleep, 100
	Send {4} 
	Sleep, 100
	Send {5} 
	Sleep, 100
	Send {6} 
	Sleep, 100
	return
}

return ;just in case
}


DontHaveItem(itemPic)
{
	ImageSearch, FoundX, FoundY, 230, 663, 606, 736, %itemPic% ;function is dependent on shop position - @ 1280x800, upper right corner of shop wants to be approx 210, 126
	if ErrorLevel ;could not find
    		return true	
	else
		return false
}

CheckIfFive() ;check if acct is level 5 ;make sure you have level5.bmp from the git repository in your working directory
{
	Send {Click 954, 57} ;view profile
	Sleep, 5000
	ImageSearch, FoundX, FoundY, 250, 316, 339, 353, level5.bmp ;scan for "level 5" with image
	if ErrorLevel ;could not find
    		return false	
	else
    		;MsgBox The icon was found at %FoundX%x%FoundY%.
		return true
return
}

BuyMasterYi() ;run from lobby screen to buy master yi
{
	Send {Click 860, 52} ;click shop button
	Sleep, 10000
	Send {Click 77, 230} ;click 'champions'
	Sleep, 5000
	Send {Click 256, 167} ;select search box
	Sleep, 2000
	Send {y}
	Sleep, 200
	Send {i}
	Sleep, 2000
	Send {Click 406, 291} ;click 'unlock'
	Sleep, 2000
	Send {Click 697, 612} ;buy with ip
	Sleep, 2000	
	Send {Click 621, 658} ;click 'done'
	Sleep, 2000

return
}

DoBattleTraining() ;run battle training automatically
{
	Send {Click 650, 50} ;click 'Play' button
	Sleep, 2000
	Send {Click 325, 296} ;click 'Tutorials' button
	Sleep, 1000
	Send {Click 512, 206} ;click 'Battle Training" button
	Sleep, 2000
	Send {Click 843, 682} ;click 'Launch' button
	Sleep, 6000
	Send {Click 663, 389} ;click 'Continue' button
	Sleep, 2000
	Send {Click 663, 389} ;click 'Continue' button again
	Sleep, 2000
	Send {Click 306, 246} ;click 'Continue' button for time limit
	Sleep, 2000
	Send {Click 375, 375} ;click 'Continue' button for champs
	Sleep, 2000
	Send {Click 311, 375} ;click 'Continue' button for ashe
	Sleep, 2000
	Send {Click 375, 375} ;click 'Continue' button for garen
	Sleep, 2000
	Send {Click 448, 375} ;click 'Continue' button for ryze
	Sleep, 2000
	Send {Click 318, 215} ;select Ashe
	Sleep, 2000
	Send {Click 402, 334} ;click 'Continue' button for allies selection
	Sleep, 2000
	Send {Click 755, 488} ;click 'Continue' button for chat box
	Sleep, 2000
	Send {Click 639, 505} ;click on summoner spells
	Sleep, 2000
	Send {Click 799, 589} ;close summoner spells box
	Sleep, 2000
	Send {Click 381, 387} ;click 'Continue' for runes and masteries
	Sleep, 2000
	Send {Click 384, 429} ;click 'Continue' button for masteries
	Sleep, 2000
	Send {Click 381, 398} ;click 'Continue' for runes
	Sleep, 2000
	Send {Click 652, 533} ;click 'Continue' button for skins
	Sleep, 2000
	Send {Click 888, 391} ;click 'Continue' for lock in
	Sleep, 2000
	Send {Click 876, 501} ;lock in
	Sleep, 90000 ;big pause here to count down and let game load
	Send {Click 824, 430} ;click 'Continue' button
	Sleep, 50000 ;long pause while lady talks
	Send {Click 1183, 259} ;move mouse cursor over seconday quests
	Sleep, 5000
	Send {Click 1253, 509} ;click hint above minimap
	Sleep, 3000
	Send {Click 985, 615} ;close hint window
	Sleep, 20000 ;wait for lady to talk
	startTime := A_Now
	while true ;spam right clicks for 19 minutes, then surrender and click continue button
	{
		Send {Click right 600, 350}
		Sleep, 5000
		Send {Click right 600, 500}
		Sleep, 5000
        	nowTime := A_Now
        	EnvSub, nowTime, %startTime%, Minutes
        	if (nowTime > 19) ;after 19 minutes, surrender
        	{
			Send {Enter}
			Sleep, 100
			Send {/}
			Sleep, 100
			Send {f}
			Sleep, 100
			Send {f}
			Sleep, 100
			Send {Enter}
			Sleep, 20000 ;give lots of time for nexus to blow up and 'continue' button to appear
			break
		}
	}

    	Send {Click 600, 500} ;click on "continue' button after defeat
    	Sleep, 15000 ;let game close and pvp.net client load
	Send {Click 640, 385} ;click continue on post battle screen
	Sleep, 2000
	Send {Click 439, 312} ;click continue for ip
	Sleep, 2000
	Send {Click 923, 739} ;click 'home'
	Sleep, 2000
	Send {Click 700, 509} ;decline co op vs ai inv
	Sleep, 2000
	Send {Click 700, 509} ;decline co op vs ai inv again
	Sleep, 2000 
	;should be back at lobby again
	BuyMasterYi()
return
}

GameLoop()
{
games = 0
while True
{
   games := games + 1
   Sleep, 100
   if games > 5
   {
      break
   }
}
SendInput, %games%
return
}


CloseLoLClient()
{
IfWinExist, PVP.net Client
{
	WinKill
}
return
}

LogIn(username, password)
{
Run, C:\Riot Games\League of Legends\lol.launcher.exe
Sleep, 15000
IfWinExist, Error
{
	WinActivate
	Send {Enter}
}

WinWait, PVP.net Patcher
WinActivate
Sleep, 2000
Send {click 701, 549} ;click on orange "play" button

WinWait, PVP.net Client
WinActivate
Sleep, 2000
Send {click 992, 334} ;username
Sleep, 1000
SendInput, %username%
Sleep, 1000
Send {click 975, 385} ;pw
SendInput, %password%
Sleep, 1000
Send {click 1108, 428} ;log in
Sleep, 15000
return
}

SelectTristYi()
{
MouseClick, left,  480,  528 ;set to first mastery page - push masteries should have been set by SetPushMasteries()
Sleep, 1000
MouseClick, left,  436,  554
Sleep, 1000
Send {Click 935, 130} ;click on search box
Sleep, 500
Send {t}
Sleep, 100
Send {r}
Sleep, 100
Send {i}
Sleep, 100
Send {s}
Sleep, 100
Send {t}
Sleep, 2000
Send {click 325, 200} ;click on top left champ space
Sleep, 2000
Send {click 651, 501} ;click on summoner spells
Sleep, 1000
Send {click 475, 275} ;click on revive
Sleep, 1000
Send {click 475, 450} ;click on promote
Sleep, 1000
Send {click 552, 374} ;click on surge if no promote
Sleep, 1000
Send {Click 900, 500} ;attempt to start game
Sleep, 30000 ;wait for load screen to pop up if successful
IfWinExist ahk_class LeagueOfLegendsWindowClass ;if client launched, return
{
	return
}
Send {click 693, 501} ;if not, dismiss the random select window
Sleep, 2000
Send {Click 935, 130} ;click on search box
Sleep, 500
Send {y}
Sleep, 100
Send {i}
Sleep, 2000
Send {click 325, 200} ;click on top left champ space
Sleep, 2000
Send {Click 900, 500} ;attempt to start game
Sleep, 2000
Send {click 581, 501} ;if there was no trist OR yi, go random
return
}

Shop(ByRef lastElixir) ;upper left hand corner of shop located @ 210, 126
{
Send {p} ;open shop
Sleep, 500
Send {Click 257, 269} ;click on home button
Sleep, 1000
Send {Click 420, 381} ;click on attack items
Sleep, 1000
Send {Click 420, 317} ;click on damage
Sleep, 1000
Send {Click 323, 346} ;click on Doran's blade
Sleep, 500
;Send {Click 698, 212} ;click on Doran's blade rec item
;Sleep, 500
Send {Click 700, 700} ;buy
Sleep, 500
Send {Click 267, 700} ;click on leftmost inventory item
Sleep, 500
Send {Click 700, 700} ;buy
Sleep, 500
Send {Click 700, 700} ;buy
Sleep, 500
Send {Click 700, 700} ;buy
Sleep, 500
Send {Click 257, 269} ;click on home button
Sleep, 1000
Send {Click 440, 566} ;click on consumables
Sleep, 1000
if (lastElixir = "red")
{
	lastElixir := "green"
	Send {Click 509, 388} ;click on green pot
	Sleep, 50
	Send {Click 509, 388} ;buy green pot
	Sleep, 500
	Send {Click 377, 388} ;click on red pot
	Sleep, 50
	Send {Click 377, 388} ;buy red pot
	Sleep, 500
}
else
{
	lastElixir := "red"
	Send {Click 377, 388} ;click on red pot
	Sleep, 50
	Send {Click 377, 388} ;buy red pot
	Sleep, 500
	Send {Click 509, 388} ;click on green pot
	Sleep, 50
	Send {Click 509, 388} ;buy green pot
	Sleep, 500
}

Send {Esc} ;close shop
Sleep, 500
Send {1} ;spam all item actives to eat elixirs
Sleep, 100
Send {2} 
Sleep, 100
Send {3} 
Sleep, 100
Send {4} 
Sleep, 100
Send {5} 
Sleep, 100
Send {6} 
Sleep, 100
return
}

Abilities()
{
Send {q} ;AS boost
Sleep, 500
Send {f} ;promote/surge
Sleep, 500
}

Suicide()
{
Sleep, 500
Send {a} ;issue attack move command
Sleep, 500
Send {Click 1262, 586}  ; click on enemy fountain via minimap
Sleep, 500
}

SkillUp()
{
Send ^e ;skill up e
Sleep, 500
Send ^q ;skill up q
Sleep, 500
}

#c:: ;this will just spam right clicks - useful for afking in game
while true
{
	Send {Click right 600, 350}
	Sleep, 5000
	Send {Click right 600, 500}
	Sleep, 5000
}
return

CreateCustomGame()
{
	Send {Click 650, 50} ;click 'Play' button
	Sleep, 2000
	Send {Click 300, 220} ;click 'Custom' button
	Sleep, 2000
	Send {Click 1000, 700} ;Create Game
	Sleep, 2000
	Send {Click 500, 640} ;select game name entry box
	Sleep, 2000
	Random, stupidName, 11111111, 99999999
	SendInput, %stupidName%
	Sleep, 2000
	Send {Click 500, 680} ;and for password
	Send {z 4}
	Send {r 2}
	Send {e 2}
	Sleep, 3000
	Send {Click 650, 725} ;go to add bots screen
	Sleep, 2000
	Send {Click 980, 120} ;click 'x' on rune alert
    Sleep, 1000    	
	Send {Click 1010, 120} ;click 'x' on new champ alert
	Sleep, 1000
	Send {Click 1100, 120} ;click 'x' on level up alert
    Sleep, 1000
	Send {Click 1010, 120} ;click 'x' on new champ alert
	Sleep, 1000
	Send {Click 1100, 120} ;click 'x' on level up alert
    Sleep, 1000
	Send {Click 850, 170} ;add random bot
	Sleep, 2000
	Send {Click 728, 154} ;click dropdown menu
	Sleep, 2000
	Send {Click 727, 201} ;scroll to top
	Sleep, 2000
	Send {Click 649, 363} ;pick malphite (worst pusher)
	Sleep, 2000

	Send {Click 900, 500} ;go to champ select
    Sleep, 5000
}
return

PlayNGames(nGames) ;will create and play N custom games, attempting to win
{
games_played = 0
while (games_played < nGames)
    {
    games_played := games_played + 1
    ;starts from LoL client lobby
        CreateCustomGame()
        SelectTristYi()
;        Sleep, 100000 ;wait for loading screen to come up before spamming
	gameNotStarted := true
	while (gameNotStarted)
	{
		IfWinExist ahk_class LeagueOfLegendsWindowClass ;if game launches, focus on it
		{
			WinActivate
		}
		Sleep, 2000
		ImageSearch, FoundX, FoundY, 175, 668, 310, 763, start_items.bmp
		if ErrorLevel ;could not find
    			gameNotStarted := true	
		else
			gameNotStarted := false
	}
        startTime := A_Now
	lastElixir := "green"
    	while true
    	{
            Suicide()
            SkillUp()
            Abilities()
        	Send {Click 600, 500} ;click on "continue' button after defeat
        	Sleep, 15000
            IfWinExist, PVP.net Client
            {
                WinActivate
                break        
            }
;            Shop(lastElixir)
	    BetterShop(lastElixir)
            nowTime := A_Now
            EnvSub, nowTime, %startTime%, Minutes
            if (nowTime > 4)
            {
                Send {d} ;try to revive
                Sleep, 1000
            }
    	}
    	Send {Click 870, 735} ;click on 'return to lobby' button 
    	Sleep, 5000

    }
}
return

FreshToFive() ;start with a fresh acct and grind it to 5
		; should start from the lobby
{
	DoBattleTraining()
	notFive = true
	while notFive
	{
		PlayNGames(1)
		amIFive := CheckIfFive()
		notFive := 1 - amIFive ;ahk has retarded boolean negation
	}
return
}

CustomsToFive() ;start with an acct that's done battle training and grind it to 5
		; should start from the lobby
{
	notFive = true
	while notFive
	{
		PlayNGames(1)
		amIFive := CheckIfFive()
		notFive := 1 - amIFive ;ahk has retarded boolean negation
	}
return
}

#w::  ;this should start from a fresh smurf in the lobby- it will grind it to 5 and then log into your main and grind there 
{
;    PlayNGames(8)
    FreshToFive()
    ;CustomsToFive()
    CloseLoLClient()
    Sleep, 2000
    LogIn("account_name", "password")
    SetPushMasteries()
    PlayNGames(9)



}
return	

#k::  ; this is the main progress engine loop FOR LOSERS (useful if you don't want to burn boosts)
while true
{
;starts from LoL client lobby
    CreateCustomGame()
	Sleep, 3000
	Send {Click 900, 200} ;pick some dude
	Sleep, 2000
	Send {Click 900, 500} ;start game
	Sleep, 2000
	;spam clicks inside of game
	while true
	{
		Send {Click right 600, 350}
		Sleep, 5000
		Send {Click right 600, 500}
		Sleep, 5000
		if a_index > 150 ;after 25 min, surrender
		{
			Send {Enter}
			Sleep, 100
			Send {/}
			Sleep, 100
			Send {s}
			Sleep, 100
			Send {u}
			Sleep, 100
			Send {r}
			Sleep, 100
			Send {r}
			Sleep, 100
			Send {e}
			Sleep, 100
			Send {n}
			Sleep, 100
			Send {d}
			Sleep, 100
			Send {e}
			Sleep, 100
			Send {r}
			Sleep, 100
			Send {Enter}
			Sleep, 20000 ;give lots of time for nexus to blow up
			break
		}
	}
	Send {Click 600, 500} ;click on "continue' button after defeat
	Sleep, 15000
	Send {Click 870, 735} ;click on 'return to lobby' button 
	Sleep, 1000
}
return	

#q::Send {Click right 1020, 735} ;for testing where stuff clicks
