#NoEnv
#InstallKeybdHook
SetKeyDelay, 100, 30
;SetWorkingDir, C:\Users\VM1\Dropbox\progress_engine ;put script and other files here

;TODO: 
;	FillReferralList - read smurf names from text file and create them/set them up
;			 - also make it spit out .ahk code we can cut+paste into ion cannon
;            - needs to hang until user acknowledges they've entered captcha
;	Make LogIn read username/pw from a file

;delays should be increased for slower computers, ideally all parameterized to one variable
;# = windows key; press it with whatever letter to start that function

#p::Pause ;useful to stop all that clicking when you're done

#y::Shop800()

#s::Reload

#q::PlayMaxGames800()

#w::  ;this should start from a fresh smurf in the lobby- it will grind it to 5 and then log into another acct and grind there 
{
    DoMain("accountname", "password")

}
return	


#b::
;SetPushMasteries()
;BurnNBoosts(1)
CreateCustomGame()
;BurnMaxBoosts()
;CustomsToFive()
return

DoModSquadMaster(name, pw, summoner1, summoner2, summoner3, summoner4)
{
    LogIn(name, pw)
    ModSquadMaster(summoner1, summoner2, summoner3, summoner4)
    CloseLoLClient()
    Sleep, 2000
    return	
}

DoModSquadSlave(name, pw)
{
    LogIn(name, pw)
    ModSquadSlave()
    CloseLoLClient()
    Sleep, 2000
    return	
}

LoseMain(name, pw)
{
    LogIn(name, pw)
    LoseMaxGames()
    CloseLoLClient()
    Sleep, 2000
    return
}

DoMain(name, pw)
{
    LogIn(name, pw)
    ;SetPushMasteries()
    PlayMaxGames()
    CloseLoLClient()
    Sleep, 2000
    return
}
    
DoSmurf(name, pw)
{
    LogIn(name, pw)
    SmurfToFive()
    CloseLoLClient()
    Sleep, 2000
    return
}
    
SmurfToFive()
{
    if CheckIfOne()
        FreshToFive()
    else
        CustomsToFive()
    return
}

CheckIfOne() ;check if acct is level 1; needs level1.bmp
{
    Send {Click 954, 57} ;view profile
    Sleep, 5000
    ImageSearch, FoundX, FoundY, 250, 316, 339, 353, level1.bmp ;scan for "level 1" with image
    if ErrorLevel ;could not find
        return false    
    else
        return true
}

FillReferralForm(smurfName) ;fill out referral form on website - make sure captcha is typed in first!
{
Random, emailSuffix, 1, 999
Random, month, 1, 12
Random, day, 1, 30
Random, year, 1981, 1992
MouseClick, left,  853,  269
Sleep, 100
Send, %smurfName%{TAB}password{TAB}password{TAB}%smurfName%%emailSuffix%{SHIFTDOWN}2{SHIFTUP}gmail.com{TAB}%month%{TAB}%day%{TAB}%year%
MouseClick, left,  729,  559
Sleep, 100
MouseClick, left,  729,  575
Sleep, 100
MouseClick, left,  887,  675
Sleep, 4000
LogIn(smurfName, "password")
Send, %smurfName%
MouseClick, left,  650,  570
Sleep, 5000
MouseClick, left,  596,  405
Sleep, 1000
MouseClick, left,  955,  534
Sleep, 2000
MouseClick, left,  421,  401
Sleep, 2000
MouseClick, left,  894,  550
Sleep, 2000
MouseClick, left,  666,  507
Sleep, 1000
MouseClick, left,  666,  507
Sleep, 3000
CloseLoLClient()

return
}

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
MouseClick, left,  216,  421
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
Sleep, 2000
MouseClick, left,  650,  530
Sleep, 2000


return
}

BestShop(ByRef lastElixir) ;for 1280x800, upper left hand corner of shop should be put @ ~210, 126
{
Send {p} ;open shop
Sleep, 500
if (DontHaveItem("wriggles.bmp") AND DontHaveItem("wriggles_hi.bmp"))
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
Sleep, 500
if (DontHaveItem("wriggles.bmp") AND DontHaveItem("wriggles_hi.bmp")) ;still no wriggles?
{
	if (DontHaveItem("razors.bmp") AND DontHaveItem("razors_hi.bmp"))	
	{
		Send {Click 302, 392} ;click on razors
		Sleep, 50
		Send {Click 302, 392} ;double click to buy
	}
	Sleep, 1000
	if (DontHaveItem("razors.bmp") AND DontHaveItem("razors_hi.bmp")) ;still no razors?
	{
		if (DontHaveItem("longsword.bmp") AND DontHaveItem("longsword_hi.bmp"))
		{
			Send {Click 499, 307} ;click on longsword
			Sleep, 50
			Send {Click 499, 307} ;double click to buy
		}
	}
}
Sleep, 500
if ((HaveItem("wriggles.bmp") OR HaveItem("wriggles_hi.bmp")) AND (DontHaveItem("sotd_hi.bmp"))) ;need low gfx version
{
	Send {Click 257, 269} ;click on home button
	Sleep, 1000
	Send {Click 420, 381} ;click on attack items
	Sleep, 1000
	Send {Click 406, 444} ;click on attack speed 
	Sleep, 1000
	Send {Click 312, 460} ;click on sword of the divine 
	Sleep, 50
	Send {Click 312, 460} ;double click to buy
}
Sleep, 500
if ((HaveItem("wriggles.bmp") OR HaveItem("wriggles_hi.bmp")) AND (DontHaveItem("sotd_hi.bmp"))) ;still no sotd?
{
	if (DontHaveItem("recurve2_hi.bmp") AND DontHaveItem("recurve3_hi.bmp")) ;need low gfx version
	{
		Send {Click 515, 348} ;click on recurve 
		Sleep, 50
		Send {Click 515, 348} ;double click to buy
	}
    Sleep, 300
	if (DontHaveItem("dagger2_hi.bmp") AND DontHaveItem("dagger3_hi.bmp")) ;need low gfx version
	{
		Send {Click 499, 307} ;click on dagger 
		Sleep, 50
		Send {Click 499, 307} ;double click to buy
	}
}
Sleep, 500
if ((HaveItem("wriggles.bmp") OR HaveItem("wriggles_hi.bmp")) AND (HaveItem("sotd_hi.bmp"))) ;need low gfx version
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
if ((HaveItem("wriggles.bmp") OR HaveItem("wriggles_hi.bmp")) AND (HaveItem("sotd_hi.bmp")) AND (DontHaveItem("tiamat3_hi.bmp"))) ; still no tiamat? ;need low gfx version
{
	if (DontHaveItem("pickaxe3_hi.bmp") AND DontHaveItem("pickaxe4_hi.bmp")) ;need low gfx version
	{
		Send {Click 515, 348} ;click on pickaxe 
		Sleep, 50
		Send {Click 515, 348} ;double click to buy
	}
    Sleep, 300
	if (DontHaveItem("longsword3_hi.bmp") AND DontHaveItem("longsword4_hi.bmp")) ;need low gfx version
	{
		Send {Click 499, 307} ;click on longsword 
		Sleep, 50
		Send {Click 499, 307} ;double click to buy
	}
}

if ((DontHaveItem("wriggles.bmp") AND DontHaveItem("wriggles_hi.bmp"))
    OR (DontHaveItem("tiamat3_hi.bmp")) ;need low gfx version
    OR (DontHaveItem("sotd_hi.bmp"))) ;need low gfx version
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
	Sleep, 1000
	return
}

return ;just in case
}


BetterShop(ByRef lastElixir) ;for 1280x800, upper left hand corner of shop should be put @ ~210, 126
{
Send {Click 250, 775} ;open shop
Sleep, 500
if (DontHaveItem("dblade5_hi.bmp"))
{
    Send {Click 257, 269} ;click on home button
    Sleep, 1000
    Send {Click 420, 381} ;click on attack items
    Sleep, 1000
    Send {Click 420, 317} ;click on damage
    Sleep, 1000
    Send {Click 320, 350} ;click on Doran's blade
    Sleep, 500
    Send {Click 700, 700} ;buy
    Sleep, 200
}
if (DontHaveItem("dblade5_hi.bmp"))
{
    Send {Click 700, 700} ;buy
    Sleep, 200
}
if (DontHaveItem("dblade5_hi.bmp"))
{
    Send {Click 700, 700} ;buy
    Sleep, 200
}
if (HaveItem("dblade5_hi.bmp") AND DontHaveItem("rageblade6_hi.bmp"))
{
    Send {Click 300, 348} ;click on pickaxe 
    Sleep, 50
    Send {Click 300, 348} ;double click to buy
    Sleep, 100
    Send {Click 500, 550} ;click on rageblade
    Sleep, 50
    Send {Click 500, 550} ;double click to buy
}
Sleep, 1000

if (DontHaveItem("rageblade6_hi.bmp")) ;save money if we don't have core items
{
	Send {Click 1050, 140} ;close shop
	Sleep, 500
	return 
}
else ;otherwise, burn money on elixirs
{		
	Sleep, 10000
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

	Send {Click 1050, 140} ;close shop
	Sleep, 1000
	return
}

return ;just in case
}

Shop800() ;for 1280x800; upper left hand corner of shop should be put @ ~1102, 37
{
Send, p
Sleep, 2000
MouseClick, left,  438,  112 ;click on "all items"
Sleep, 1000                                            
MouseClick, left,  430,  158 ;click on text search box
Sleep, 200                                             
Send, hydra                  ;serach for hydra
MouseClick, left,  235,  198 ;select item
Sleep, 1000                                           
MouseClick, left,  878,  251 ;try to buy hydra
Sleep, 20                                             
MouseClick, left,  878,  251
Sleep, 500                                            
MouseClick, left,  785,  318 ;try to buy tiamat
Sleep, 20                                             
MouseClick, left,  785,  318
Sleep, 500                                            
MouseClick, left,  698,  391 ;try to buy pickaxe
Sleep, 20                                             
MouseClick, left,  698,  391
Sleep, 500                                            
MouseClick, left,  1057,  57 ;close shop
Sleep, 2000
return
}

Shop() ;for 1920x1080; upper left hand corner of shop should be put @ ~1538, 81
{
;MouseMove,  249,  1050 ;open shop
;Sleep, 500
;MouseClick, left,  249,  1050 ;open shop
Send, p
Sleep, 1000
MouseClick, left,  739,  187 ;click on "all items"
Sleep, 1000
MouseClick, left,  687,  238 ;click on text search box
Sleep, 500
;Send, doran's{SPACE}blade ;serach for doran's blade
;Send, recurve{SPACE}bow ;serach for recuve bow
Send, hydra ;serach for hydra
MouseClick, left,  493,  288 ;select item
Sleep, 1000
;MouseClick, left,  1401,  662 ;buy item
MouseClick, left,  1254,  351 ;try to buy hydra
Sleep, 20
MouseClick, left,  1254,  351
Sleep, 20
MouseClick, left,  1127,  440 ;try to buy tiamat
Sleep, 20
MouseClick, left,  1124,  439
Sleep, 20
MouseClick, left,  1040,  526 ;try to buy pickaxe
Sleep, 20
MouseClick, left,  1040,  526
Sleep, 20
MouseClick, left,  1507,  111 ;close shop
Sleep, 2000
return
}

DontHaveItem(itemPic)
{
	ImageSearch, FoundX, FoundY, 230, 663, 606, 736, %itemPic% ;function is dependent on shop position - @ 1280x800, upper right corner of shop wants to be approx 210, 126
	if ErrorLevel ;could not find
   		return true	
	else
		return false
}

HaveItem(itemPic)
{
	ImageSearch, FoundX, FoundY, 230, 663, 606, 736, %itemPic% ;function is dependent on shop position - @ 1280x800, upper right corner of shop wants to be approx 210, 126
	if ErrorLevel ;could not find
   		return false 
	else
		return true 
}

CheckIfFive() ;check if acct is level 5 ;make sure you have level5.bmp from the git repository in your working directory
{
	Send {Click 954, 57} ;view profile
	Sleep, 5000
	ImageSearch, FoundX, FoundY, 250, 316, 339, 353, level5.bmp ;scan for "level 5" with image
	if ErrorLevel ;could not find
    		return false	
	else
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
	Send {Click 406, 310} ;click 'unlock'
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
        statsNotLoaded := true
        while statsNotLoaded
        {
		ImageSearch, FoundX, FoundY, 847, 715, 973, 755, home.bmp
		if ErrorLevel ;could not find
    	        	statsNotLoaded := true	
		else
			statsNotLoaded := false
                Sleep, 1000
        }
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
While 1
{
    IfWinExist, Error
    {
        WinActivate
        Send {Enter}
        Break
    }
    IfWinExist, PVP.net Patcher
        Break
}

WinWait, PVP.net Patcher
WinActivate
Sleep, 5000
Send {click 701, 549} ;click on orange "play" button

WinWait, PVP.net Client
WinActivate
Sleep, 7000
Send {click 293,  320} ;username
Sleep, 1000
Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
SendInput, %username%
Sleep, 1000
Send {click 284, 379} ;pw
SendInput, %password%
Sleep, 1000s
Send {click 336,  431} ;log in
Sleep, 20000
return
}

SelectTristYi()
{
MouseClick, left,  480,  528 ;set to first mastery page - push masteries should have been set by SetPushMasteries()
Sleep, 1000
MouseClick, left,  436,  554
Sleep, 1000
MouseClick, left,  368,  497 ;set to Dat AS(S) super AS page from jungling
Sleep, 1000
MouseClick, left,  497,  530
Sleep, 1000
MouseClick, left,  403,  702
Sleep, 1000
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
;Send {Click 935, 130} ;click on search box
;Sleep, 500
;Send {t}
;Sleep, 100
;Send {r}
;Sleep, 100
;Send {i}
;Sleep, 100
;Send {s}
;Sleep, 100
;Send {t}
;Sleep, 2000
;Send {click 325, 200} ;click on top left champ space
;Sleep, 2000
Send {click 623, 528} ;click on summoner spells
Sleep, 1000
Send {click 475, 245} ;click on revive
Sleep, 1000
Send {click 809, 213} ;click on ghost
Sleep, 1000
Send {Click 900, 500} ;attempt to start game
Sleep, 30000 ;wait for load screen to pop up if successful
IfWinExist ahk_class LeagueOfLegendsWindowClass ;if client launched, return
{
	return
}
Send {click 693, 501} ;if not, dismiss the random select window
Sleep, 2000
Send {click 581, 501} ;if there was no yi, go random
return
}

CheckIfLow()
{
PixelGetColor, health_px, 803, 755
if (health_px = 0x000000) {
	return true
}
else {
	return false
}
}

CheckIfDead()
{
PixelGetColor, skull_px, 35, 757
if (skull_px = 0x000000) {
	return true
}
else {
	return false
}
}

Abilities()
{
Send {r} ;AS boost
Sleep, 100
Send {d} ;revive
Sleep, 100
Send {f} ;heal
Sleep, 100
/*
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
*/
}

Suicide() ;only works on 1920x1080 res
{
Sleep, 100
Send {a} ;issue attack move command
Sleep, 1000
Send {Click 1906, 832}  ; click on enemy fountain via minimap
Sleep, 1000
}

Suicide800() ;tweaked to work on 1280x800
{
Sleep, 100
Send {a} ;issue attack move command
Sleep, 1000
Send {Click 1265, 618}  ; click on enemy fountain via minimap
Sleep, 1000
}

SkillUp()
{
Send ^r ;skill up r
Sleep, 100
Send ^e ;skill up e
Sleep, 100
Send ^q ;skill up q
Sleep, 100
}

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
	Send {Click 729, 192} ;scroll to top
	Sleep, 400
	Send {Click 729, 192} ;scroll to top
	Sleep, 400
	Send {Click 729, 192} ;scroll to top
	Sleep, 400
	Send {Click 729, 192} ;scroll to top
	Sleep, 400
	Send {Click 729, 192} ;scroll to top
	Sleep, 400
	Send {Click 700, 180} ;pick annie
	Sleep, 4000
	Send {Click 728, 154} ;click dropdown menu
	Sleep, 2000
	Send {Click 729, 330} ;scroll to leona
	Sleep, 1000
	Send {Click 650, 235} ;pick leona (worst pusher)
	Sleep, 4000
	Send {Click 900, 500} ;go to champ select
    Sleep, 5000
}
return

MasterCreateGame(summoner1, summoner2, summoner3, summoner4)
{
	MouseClick, left,  669,  33 ;click orange "Play" button
	Sleep, 2000
	MouseClick, left,  303,  175 ;co-op vs ai
	Sleep, 1000
	MouseClick, left,  541,  150 ;classic
	Sleep, 1000
	MouseClick, left,  700,  150 ;summoner's rift
	Sleep, 1000
	MouseClick, left,  891,  152 ;beginner
	Sleep, 1000
	MouseClick, left,  928,  708 ;invite my own teammates
	Sleep, 2000
	MouseClick, left,  958,  543 ;invite
	Sleep, 2000
	MouseClick, left,  726,  200 ;click on text box
	Sleep, 500
	Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
	Sleep, 500
	Send, %summoner1%	;type in summoner1's name
	Sleep, 500
	MouseClick, left,  1098,  207 ;add to invite list
	Sleep, 500
	MouseClick, left,  726,  200 ;click on text box
	Sleep, 500
	Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
	Sleep, 500
	Send, %summoner2%	;type in summoner2's name
	Sleep, 500
	MouseClick, left,  1098,  207 ;add to invite list
	Sleep, 500
	MouseClick, left,  726,  200 ;click on text box
	Sleep, 500
	Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
	Sleep, 500
	Send, %summoner3%	;type in summoner3's name
	Sleep, 500
	MouseClick, left,  1098,  207 ;add to invite list
	Sleep, 500
	MouseClick, left,  726,  200 ;click on text box
	Sleep, 500
	Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
	Sleep, 500
	Send, %summoner4%	;type in summoner4's name
	Sleep, 500
	MouseClick, left,  1098,  207 ;add to invite list
	Sleep, 500
	MouseClick, left,  925,  719 ;click "Invite players"
	Sleep, 1000
	while True		;check that first player has joined
		{
		Sleep, 500
		PixelSearch, FoundX, FoundY, 989, 383, 1006, 403, 0x01BC04 ;search for the green of "Accepted"
		if ErrorLevel ;could not find
       		    Sleep, 10	
		else
		    break	
		}
	Sleep, 1000
	while True		;check that second player has joined
		{
		Sleep, 500
		PixelSearch, FoundX, FoundY, 989, 403, 1006, 429, 0x01BC04 ;search for the green of "Accepted"
		if ErrorLevel ;could not find
       		    Sleep, 10	
		else
		    break	
		}
	Sleep, 1000
	while True		;check that third player has joined
		{
		Sleep, 500
		PixelSearch, FoundX, FoundY, 989, 429, 1006, 456, 0x01BC04 ;search for the green of "Accepted"
		if ErrorLevel ;could not find
       		    Sleep, 10	
		else
		    break	
		}
	Sleep, 1000
	while True		;check that fourth player has joined
		{
		Sleep, 500
		PixelSearch, FoundX, FoundY, 989, 456, 1006, 480, 0x01BC04 ;search for the green of "Accepted"
		if ErrorLevel ;could not find
       		    Sleep, 10	
		else
		    break	
		}
	Sleep, 1000
	MouseClick, left, 650, 550 ;start game
	Sleep, 7000
	MouseClick, left, 548, 445 ;click "accept" when match is made
}
return

SlaveJoinGame()
{
MouseClick, left, 950, 50
Sleep, 2000
while True
	{
	Sleep, 1000
;	ImageSearch, FoundX, FoundY, 950, 550, 1279, 775, romancandle_invite.bmp
	PixelSearch, FoundX, FoundY, 950, 550, 1100, 700, 0xFEFEFE
	if ErrorLevel ;could not find
       	    Sleep, 10	
	else
	    break	
	}
MouseClick, left, 1077, 741
Sleep, 13000
MouseClick, left, 548, 445 ;click "accept" when match is made
}
return

BurnMaxBoosts() ;will create and play custom games until custom minutes are exhausted
{
minutesRemain := true
while (minutesRemain)
{
    ;starts from LoL client lobby
    CreateCustomGame()
    SelectTristYi()
	gameNotStarted := true
	while (gameNotStarted)
	{
		IfWinExist ahk_class LeagueOfLegendsWindowClass ;if game launches, focus on it
		{
			WinActivate
		}
		Sleep, 1000
		ImageSearch, FoundX, FoundY, 175, 668, 310, 763, start_items.bmp
		if ErrorLevel ;could not find
       	    gameNotStarted := true	
		else
		    gameNotStarted := false
		ImageSearch, FoundX, FoundY, 175, 668, 310, 763, start_items_hi.bmp
		if ErrorLevel ;could not find
       	    gameNotStarted := true	
		else
		    gameNotStarted := false
	}
    startTime := A_Now
    lastElixir := "green"
    gameOngoing := true
    minionsHaventSpawned := true 
    Sleep, 15000

    BetterShop(lastElixir)
    ;BestShop(lastElixir)
    Suicide() ;tower dive once 'cause there's nothing better to do
    lastLow := A_Now
    while minionsHaventSpawned
    {
        curTime := A_Now
        EnvSub curTime, %startTime%, Seconds
        if curTime > 85
        {
            minionsHaventSpawned := false
            break
        }
        Sleep, 1000
    }
    
    while gameOngoing
    {
        Suicide() 
        SkillUp()
        Abilities()
        Send {Click 600, 500} ;click on "continue' button after defeat
        IfWinExist, PVP.net Client
        {
            gameOngoing := false
            WinActivate
            break        
        }
	if (CheckIfDead()) {
	    BetterShop(lastElixir)
	    Send {d}
	}
	else {
	    Sleep, 10
	}
;        ImageSearch, FoundX, FoundY, 16, 725, 46, 763, dead.bmp ;check if dead ;possibly deprecated due to patch
;        ImageSearch, FoundX, FoundY, 16, 725, 46, 763, dead_new.bmp ;check if dead
;        if ErrorLevel ;didn't find integrated gfx skull
;            ImageSearch, FoundX, FoundY, 16, 725, 46, 763, dead_hi.bmp
;        	if ErrorLevel ;didn't find discrete gfx skull
;    	    Sleep, 10
;            else
;    	    {
;                BetterShop(lastElixir)
;                ;BestShop(lastElixir)
;                Send {d} ;try to revive
;    	    }
        nowTime := A_Now
        EnvSub, nowTime, %startTime%, Seconds
        nowTime2 := A_Now
        EnvSub, nowTime2, %startTime%, Minutes
        if (mod(nowTime, 180) > 120 AND mod(nowTime, 180) < 130 AND nowTime2 < 10) ;prepare to sync w/ siege creep for promote
        {
	    Send {Click right 1087, 763} ;retreat
            Sleep, 2000
            Send {b} ;return to base
            Sleep, 8200
            BetterShop(lastElixir)
            ;BestShop(lastElixir)
            Suicide()
            Sleep, 10000
        }
        nowTime := A_Now
        EnvSub, nowTime, %lastLow%, Seconds
        if (CheckIfLow() AND (nowTime > 20)) {
            lastLow := A_Now
            Send {Click right 1087, 763} ;retreat
            Sleep, 2000
        }
	}
    statsNotLoaded := true
    while statsNotLoaded
    {
		ImageSearch, FoundX, FoundY, 847, 715, 973, 755, home.bmp
		if ErrorLevel ;could not find
    		statsNotLoaded := true	
		else
			statsNotLoaded := false
        Sleep, 1000
    }
	ImageSearch, FoundX, FoundY, 14, 231, 137, 281, 0minutes.bmp
	if ErrorLevel ;could not find
		minutesRemain := true	
	else
		minutesRemain := false

	Send {Click 870, 735} ;click on 'return to lobby' button 
	Sleep, 5000

}
}
return


BurnNBoosts(nGames) ;will create and play N custom games, attempting to win
{
games_played = 0
while (games_played < nGames)
{
    games_played := games_played + 1
    ;starts from LoL client lobby
    CreateCustomGame()
    SelectTristYi()
	gameNotStarted := true
	while (gameNotStarted)
	{
		IfWinExist ahk_class LeagueOfLegendsWindowClass ;if game launches, focus on it
		{
			WinActivate
		}
		Sleep, 1000
		ImageSearch, FoundX, FoundY, 175, 668, 310, 763, start_items.bmp
		if ErrorLevel ;could not find
       	    gameNotStarted := true	
		else
		    gameNotStarted := false
		ImageSearch, FoundX, FoundY, 175, 668, 310, 763, start_items_hi.bmp
		if ErrorLevel ;could not find
       	    gameNotStarted := true	
		else
		    gameNotStarted := false
	}
    startTime := A_Now
    lastElixir := "green"
    gameOngoing := true
    minionsHaventSpawned := true 
    Sleep, 15000

    BetterShop(lastElixir)
    ;BestShop(lastElixir)
    Suicide() ;tower dive once 'cause there's nothing better to do
    while minionsHaventSpawned
    {
        curTime := A_Now
        EnvSub curTime, %startTime%, Seconds
        if curTime > 85
        {
            minionsHaventSpawned := false
            break
        }
        Sleep, 1000
    }
    
    while gameOngoing
    {
        Suicide() 
        SkillUp()
        Abilities()
        Send {Click 600, 500} ;click on "continue' button after defeat
        IfWinExist, PVP.net Client
        {
            gameOngoing := false
            WinActivate
            break        
        }
        ImageSearch, FoundX, FoundY, 16, 725, 46, 763, dead.bmp
        if ErrorLevel ;didn't find integrated gfx skull
            ImageSearch, FoundX, FoundY, 16, 725, 46, 763, dead_hi.bmp
        	if ErrorLevel ;didn't find discrete gfx skull
    	    Sleep, 10
            else
    	    {
                BetterShop(lastElixir)
                ;BestShop(lastElixir)
                Send {d} ;try to revive
    	    }
        nowTime := A_Now
        EnvSub, nowTime, %startTime%, Seconds
        nowTime2 := A_Now
        EnvSub, nowTime2, %startTime%, Minutes
        if (mod(nowTime, 180) > 120 AND mod(nowTime, 180) < 130 AND nowTime2 < 10) ;prepare to sync w/ siege creep for promote
        {
	    Send {Click right 1087, 763} ;retreat
            Sleep, 2000
            Send {b} ;return to base
            Sleep, 8200
            BetterShop(lastElixir)
            ;BestShop(lastElixir)
            Suicide()
            Sleep, 10000
        }
	}
    statsNotLoaded := true
    while statsNotLoaded
    {
		ImageSearch, FoundX, FoundY, 847, 715, 973, 755, home.bmp
		if ErrorLevel ;could not find
    		statsNotLoaded := true	
		else
			statsNotLoaded := false
        Sleep, 1000
    }
	Send {Click 870, 735} ;click on 'return to lobby' button 
	Sleep, 5000

}
}
return

PlayMaxGames800() ;will create and play custom games, attempting to win, until custom minutes expire
                  ;works on 1280x800 res
{
;    minutesRemain := true
;    while (minutesRemain)
;    {
;        ;starts from LoL client lobby
;        CreateCustomGame()
;        SelectTristYi()
;        Sleep, 20000 ;open-loop wait for countdown and loading of game
    	while true
    	{
            Suicide800()
            SkillUp()
            Abilities()
            Sleep, 1000
            Send {Click 600, 500} ;click on "continue' button after defeat
            IfWinExist, PVP.net Client
            {
                WinActivate
                break        
            }
            Sleep, 2000
            Shop800()
        }
;        statsNotLoaded := true
;        while statsNotLoaded
;        {
;    		ImageSearch, FoundX, FoundY, 847, 715, 973, 755, home.bmp
;    		if ErrorLevel ;could not find
;        		statsNotLoaded := true	
;    		else
;    			statsNotLoaded := false
;            Sleep, 1000
;        }
;    	ImageSearch, FoundX, FoundY, 14, 231, 137, 281, 0minutes.bmp
;    	if ErrorLevel ;could not find
;    		minutesRemain := true	
;    	else
;    		minutesRemain := false
;    
;    	Send {Click 870, 735} ;click on 'return to lobby' button 
;    	Sleep, 5000
;    }
}
return



PlayMaxGames() ;will create and play custom games, attempting to win, until custom minutes expire
               ;works on 1920x1080 res
{
    minutesRemain := true
    while (minutesRemain)
    {
        ;starts from LoL client lobby
        CreateCustomGame()
        SelectTristYi()
        Sleep, 20000 ;open-loop wait for countdown and loading of game
    	while true
    	{
            Suicide()
            SkillUp()
            Abilities()
            Sleep, 1000
            Send {Click 965, 733} ;click on "continue' button after defeat
            IfWinExist, PVP.net Client
            {
                WinActivate
                break        
            }
            Sleep, 2000
            Shop()
        }
        statsNotLoaded := true
        while statsNotLoaded
        {
    		ImageSearch, FoundX, FoundY, 847, 715, 973, 755, home.bmp
    		if ErrorLevel ;could not find
        		statsNotLoaded := true	
    		else
    			statsNotLoaded := false
            Sleep, 1000
        }
    	ImageSearch, FoundX, FoundY, 14, 231, 137, 281, 0minutes.bmp
    	if ErrorLevel ;could not find
    		minutesRemain := true	
    	else
    		minutesRemain := false
    
    	Send {Click 870, 735} ;click on 'return to lobby' button 
    	Sleep, 5000
    }
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
		ImageSearch, FoundX, FoundY, 175, 668, 310, 763, start_items_hi.bmp
		if ErrorLevel ;could not find
    			gameNotStarted := true	
		else
			gameNotStarted := false
	}
        startTime := A_Now
	lastElixir := "green"
        lastLow := A_Now
	while true
	{
        Suicide()
        SkillUp()
        Abilities()
        Send {Click 600, 500} ;click on "continue' button after defeat
        IfWinExist, PVP.net Client
        {
            WinActivate
            break        
        }
        ;Shop(lastElixir)
        ImageSearch, FoundX, FoundY, 16, 725, 46, 763, dead.bmp ;check if dead
        if ErrorLevel ;didn't find integrated gfx skull
            ImageSearch, FoundX, FoundY, 16, 725, 46, 763, dead_yi_hi.png
        	if ErrorLevel ;didn't find discrete gfx skullaa
    	    Sleep, 10
            else
    	    {
                BetterShop(lastElixir)
                ;BestShop(lastElixir)
		nowTime := A_Now
		EnvSub, nowTime, %startTime%, Minutes
		If (nowTime > 4){
	                Send {d} ;try to revive
		}
    	    }
        nowTime := A_Now
        EnvSub, nowTime, %lastLow%, Seconds
        if (CheckIfLow() AND (nowTime > 30)) {
            lastLow := A_Now
            Send {Click right 1087, 763} ;retreat
            Sleep, 2500
        }
    }
    statsNotLoaded := true
    while statsNotLoaded
    {
		ImageSearch, FoundX, FoundY, 847, 715, 973, 755, home.bmp
		if ErrorLevel ;could not find
    		statsNotLoaded := true	
		else
			statsNotLoaded := false
        Sleep, 1000
    }
	Send {Click 870, 735} ;click on 'return to lobby' button 
	Sleep, 5000

}
}
return

LoseMaxGames() ;will create and lose custom games until custom minutes are exhausted
{
minutesRemain := true
while (minutesRemain)
{
    CreateCustomGame()
	Sleep, 3000
	Send {Click 900, 200} ;pick some dude
	Sleep, 2000
	Send {Click 900, 500} ;start game
	Sleep, 20000
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
			Send {f}
			Sleep, 100
			Send {f}
			Sleep, 100
			Send {Enter}
		        Send {Click 600, 500} ;click on "continue' button after defeat
        		IfWinExist, PVP.net Client
        		{
            			WinActivate
            			break        
        		}

		}
	}
    statsNotLoaded := true
    while statsNotLoaded
    {
		ImageSearch, FoundX, FoundY, 847, 715, 973, 755, home.bmp
		if ErrorLevel ;could not find
    		statsNotLoaded := true	
		else
			statsNotLoaded := false
        Sleep, 1000
    }
	ImageSearch, FoundX, FoundY, 14, 231, 137, 281, 0minutes.bmp
	if ErrorLevel ;could not find
		minutesRemain := true	
	else
		minutesRemain := false

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
		BurnNBoosts(1)
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

#c:: ;this will just spam right clicks - useful for afking in game
while true
{
	Send {Click right 600, 350}
	Sleep, 5000
	Send {Click right 600, 500}
	Sleep, 5000
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
			Send {f}
			Sleep, 100
			Send {f}
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

ModSquadMaster(summoner1, summoner2, summoner3, summoner4) ;will beast the shit out of Co-op vs AI
{
while True
{
    ;starts from LoL client lobby
    MasterCreateGame(summoner1, summoner2, summoner3, summoner4)
    SelectTristYi()
    Sleep, 95000
    Shop()
    Suicide() ;tower dive once 'cause there's nothing better to do
    while True
    {
        Suicide() 
        SkillUp()
        Abilities()
	Shop()
        Send {Click 600, 500} ;click on "continue' button after defeat
        IfWinExist, PVP.net Client
        {
            gameOngoing := false
            WinActivate
            break        
        }

    }
    statsNotLoaded := true
    while statsNotLoaded
    {
		ImageSearch, FoundX, FoundY, 847, 715, 973, 755, home.bmp
		if ErrorLevel ;could not find
    		statsNotLoaded := true	
		else
			statsNotLoaded := false
        Sleep, 1000
    }
	Send {Click 870, 735} ;click on 'return to lobby' button 
	Sleep, 5000
}
}
return

ModSquadSlave() ;will beast the shit out of Co-op vs AI
{
while True
{
    ;starts from LoL client lobby
    SlaveJoinGame()
    SelectTristYi() ;need a 'SelectModSquad' that just goes through 5 desired champs sequentially
    Sleep, 95000 ;might need to increase this
    Shop()
    Suicide() ;tower dive once 'cause there's nothing better to do
    while True
    {
        Suicide() 
        SkillUp()
        Abilities()
	Shop()
        Send {Click 600, 500} ;click on "continue' button after defeat
        IfWinExist, PVP.net Client
        {
            gameOngoing := false
            WinActivate
            break        
        }

    }
    statsNotLoaded := true
    while statsNotLoaded
    {
		ImageSearch, FoundX, FoundY, 847, 715, 973, 755, home.bmp
		if ErrorLevel ;could not find
    		statsNotLoaded := true	
		else
			statsNotLoaded := false
        Sleep, 1000
    }
	Send {Click 870, 735} ;click on 'return to lobby' button 
	Sleep, 5000
}
}
return

