#NoEnv
#InstallKeybdHook
SetKeyDelay, 100, 30

#s::Reload

#t::Pause

#w::
PlayMaxGames(true)
return

;Creates and plays games until there are no custom minutes remaining.
;Starts from client.
;Meant for 1024x768 resolution.
;use waitLong = true if you want to wait 90 extra seconds (for random choice to work)
PlayMaxGames(waitLong)
{
    done := false
    while (!done)
    {
        done := PlayGame(waitLong)
    }
}

;Creates and plays a game.
;Starts from client.
;Meant for 1024x768 resolution.
;returns true if 0 minutes found, or false otherwise
PlayGame(waitLong)
{
    CreateCustomGame()
    SelectYi()
    Sleep, 20000 ;open-loop wait for countdown and loading of game
    if (waitLong)
        Sleep, 90000
    WaitGameStart()
    GameLoop()
    
    x := CleanupGame()
    return x
}

;waits for game to start
WaitGameStart()
{
    while (true)
    {
        IfWinExist ahk_class RiotWindowClass ;if game launches, focus on it
        {
            WinActivate
            return
        }
        Sleep, 2000
    }
}

;In-game loop of pushing/shopping.
GameLoop()
{
    while true
    {
        Suicide()
        SkillUp()
        Abilities()
        Sleep, 1000
        Send {Click 510, 416} ;click on "continue' button after defeat
        IfWinExist, PVP.net Client
        {
            WinActivate
            return      
        }
        Sleep, 2000
        Shop()
    }
}

;returns true if 0 minutes found, or false otherwise
CleanupGame()
{
    x := StatsCheck()
    Send {Click 700, 590} ;click on 'return to lobby' button 
    Sleep, 5000
    return x
}

StatsCheck()
{
    ;wait for stats to load
    statsNotLoaded := true
    while statsNotLoaded
    {
        ImageSearch, FoundX, FoundY, 676, 570, 783, 607, home.png
        if ErrorLevel ;could not find
            statsNotLoaded := true	
        else
            statsNotLoaded := false
        Sleep, 1000
    }
    ImageSearch, FoundX, FoundY, 14, 192, 137, 281, 0minutes.png
    if ErrorLevel ;could not find
        return false
    else
        return true
}


Suicide()
{
    Sleep, 100
    Send {a} ;issue attack move command
    Sleep, 1000
    Send {Click 1011, 598}  ; click on enemy fountain via minimap
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

Shop()
{
Send, p
Sleep, 1000
Send, {CTRLDOWN}l{CTRLUP}hydra
Sleep, 500
MouseClick, left,  203, 189
Sleep, 300
MouseClick, right,  730,  253
Sleep, 300
MouseClick, right,  640,  311
Sleep, 300
MouseClick, right,  570,  375
Sleep, 300
MouseClick, left,  923, 64
Sleep, 100
return
}

;Starting from client, create a custom game.
CreateCustomGame()
{
    Send {Click 478, 32} ;click 'Play' button
	Sleep, 2000
	Send {Click 238, 186} ;click 'Custom' button
	Sleep, 2000
	Send {Click 753, 562} ;Create Game
	Sleep, 2000
	Send {Click 353, 516} ;select game name entry box
	Sleep, 2000
	Random, stupidName, 11111111, 99999999
	SendInput, %stupidName%
	Sleep, 2000
	Send {Click 353, 546} ;and for password
	Send {z 4}
	Send {r 2}
	Send {e 2}
	Sleep, 3000
	Send {Click 476, 588} ;go to add bots screen
        ;Sleep, 2000
        ;Send {Click 980, 120} ;click 'x' on rune alert
        ;Sleep, 1000    	
        ;Send {Click 1010, 120} ;click 'x' on new champ alert
        ;Sleep, 1000
        ;Send {Click 1100, 120} ;click 'x' on level up alert
        ;Sleep, 1000
        ;Send {Click 1010, 120} ;click 'x' on new champ alert
        ;Sleep, 1000
        ;Send {Click 1100, 120} ;click 'x' on level up alert
        ;Sleep, 1000
    Sleep, 2000
	Send {Click 727, 130} ;add random bot
	Sleep, 2000
	Send {Click 576, 126} ;click dropdown menu
	Sleep, 2000
	Send {Click 580, 150} ;scroll to top
	Sleep, 400
	Send {Click 580, 150} ;scroll to top
	Sleep, 400
	Send {Click 580, 150} ;scroll to top
	Sleep, 400
	Send {Click 580, 150} ;scroll to top
	Sleep, 400
	Send {Click 580, 150} ;scroll to top
	Sleep, 400
	Send {Click 554, 155} ;pick annie
	Sleep, 4000
	Send {Click 584, 132} ;click dropdown menu
	Sleep, 2000
	Send {Click 584, 248} ;scroll to leona
	Sleep, 1000
	Send {Click 520, 193} ;pick leona (worst pusher)
	Sleep, 4000
	Send {Click 687, 392} ;go to champ select
    Sleep, 5000
}

SelectYi()
{
;MouseClick, left,  480,  528 ;set to first mastery page - push masteries should have been set by SetPushMasteries()
;Sleep, 1000
;MouseClick, left,  436,  554
;Sleep, 1000
;MouseClick, left,  368,  497 ;set to Dat AS(S) super AS page from jungling
;Sleep, 1000
;MouseClick, left,  497,  530
;Sleep, 1000
;MouseClick, left,  403,  702
;Sleep, 1000
    Send {Click 731, 110} ;click on search box
    Sleep, 500
    Send {y}
    Sleep, 100
    Send {i}
    Sleep, 2000
    Send {click 274, 174} ;click on top left champ space
    Sleep, 2000
    Send {Click 702, 410} ;attempt to start game
    Sleep, 2000
    Send {click 517, 421} ;click on summoner spells
    Sleep, 1000
    Send {click 393, 175} ;click on revive
    Sleep, 1000
    Send {click 648, 175} ;click on ghost
    Sleep, 1000
    Send {Click 702, 410} ;attempt to start game
    Sleep, 30000 ;wait for load screen to pop up if successful
}