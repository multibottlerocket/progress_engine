#NoEnv
#InstallKeybdHook
SetKeyDelay, 100, 30

#s::Reload

#t::Pause

;this is a utility testing method - feel free to swap it out for whatever function
#v::
;LogIn("C:\accountData.txt")
MasterCreateGame("mytroll17", "mytroll18", "mangohichew", "cherryhichew")
WinGame(true)
return

#w::
WinGame(true)
return

#x::
SlaveJoinGame()
WinGame(true) ; SelectYi() has been temporarily commented out for testing!
;WinGameLoop()
return

;Creates and plays games until there are no custom minutes remaining.
;Starts from client.
;Meant for 1024x768 resolution.
LoseMaxGames()
{
    done := false
    while (!done)cC
    {
        done := LoseGame()
    }
}

;Creates and plays games until there are no custom minutes remaining.
;Starts from client.
;Meant for 1024x768 resolution.
WinMaxGames(waitLong)
{
    done := false
    while (!done)
    {
        done := WinGame(waitLong)
    }
}

;Creates and loses a game by surrender.
;Starts from client.
;Meant for 1024x768 resolution.
;returns true if 0 minutes found, or false otherwise
LoseGame()
{
    CreateCustomGame()
    SelectFirstChamp()
    Sleep, 20000 ;open-loop wait for countdown and loading of game
    WaitGameStart()
    LoseGameLoop()
    
    x := CleanupGame()
    return x
}

;Creates and plays a game.
;Starts from client.
;Meant for 1024x768 resolution.
;returns true if 0 minutes found, or false otherwise
WinGame(waitLong)
{
;    CreateCustomGame()
    ;SelectYi() ; ***temporarily commented out for testing!***S
    Sleep, 20000 ;open-loop wait for countdown and loading of game
    if (waitLong)
        Sleep, 90000
    WaitGameStart()
    WinGameLoop()
    
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

;In-game loop of walking around. Surrenders after a while.
LoseGameLoop()
{
    while true
    {
        Send {Click right 300, 350}
        Sleep, 5000
        Send {Click right 300, 500}
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
        }
        Send {Click 510, 416} ;click on "continue' button after defeat
        IfWinExist, PVP.net Client
        {
            WinActivate
            return       
        }
    }
}

;In-game loop of pushing/shopping.
WinGameLoop()
{
    while true
    {
        Suicide()
        SkillUp()
        Abilities()
        Sleep, 1000
        Send {Click 510, 416} ;click on "continue' button after defeat/victory
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
MouseClick, left, 137,  754 ;click to open shop
Sleep, 100
MouseClick, left, 137,  754 ;click to open shop
Sleep, 100
MouseClick, left, 137,  754 ;click to open shop
Sleep, 1000
Send, {CTRLDOWN}l{CTRLUP}loo
Sleep, 500
MouseClick, left,  203, 189 ;select BT
Sleep, 300
MouseClick, left,  737,  233 ;try to buy BT
MouseClick, left,  737,  233
Sleep, 300
MouseClick, left,  625,  293 ;try to buy BF sword
MouseClick, left,  625,  293
Sleep, 300
MouseClick, left,  815,  290 ;try to buy vamp scepter
MouseClick, left,  815,  290
Sleep, 300
MouseClick, left,  923, 64 ;click to close shop
Sleep, 100

;Send, {CTRLDOWN}l{CTRLUP}ydr ;old hydra-buying logic
;Sleep, 500
;MouseClick, left,  203, 189
;Sleep, 300
;MouseClick, left,  730,  253
;MouseClick, left,  730,  253
;Sleep, 300
;MouseClick, left,  640,  311
;MouseClick, left,  640,  311
;Sleep, 300
;MouseClick, left,  570,  375
;MouseClick, left,  570,  375
;Sleep, 300
;MouseClick, left,  923, 64
;Sleep, 100
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
    Send {Click 582, 153} ;scroll to top
    Sleep, 400
    Send {Click 582, 153} ;scroll to top
    Sleep, 400
    Send {Click 582, 153} ;scroll to top
    Sleep, 400
    Send {Click 582, 153} ;scroll to top
    Sleep, 400
    Send {Click 582, 153} ;scroll to top
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

SelectFirstChamp()
{
    Send {click 274, 174} ;click on top left champ space
    Sleep, 2000
    Send {Click 702, 410} ;attempt to start game
    Sleep, 30000 ;wait for load screen to pop up if successful
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

CloseLoLClient()
{
    IfWinExist, PVP.net Client
    {
        WinKill
    }
    return
}

LogIn(accountData) ;accountData should have account name on first line and pw on second
{
    FileReadLine, username, %accountData%, 1
    FileReadLine, password, %accountData%, 2

    Run, C:\Riot Games\League of Legends\lol.launcher.exe
    Sleep, 15000
    While 1
    {
        IfWinExist, Error ;silly hack to dismiss the "another instance of LoL is running" box
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
    Send {click 260,  240} ;username
    Sleep, 1000
    Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
    SendInput, %username%
    Sleep, 2000
    Send {click 230, 289} ;pw
    SendInput, %password%
    Sleep, 2000
    Send {click 302,  319} ;log in
    Sleep, 20000
    return
}

MasterCreateGame(summoner1, summoner2, summoner3, summoner4)
{
    MouseClick, left,  511,  35 ;click orange "Play" button
    Sleep, 2000
    MouseClick, left,  278,  139 ;co-op vs ai
    Sleep, 1000
    MouseClick, left,  393,  119 ;classic
    Sleep, 1000
    MouseClick, left,  592,  137 ;summoner's rift
    Sleep, 1000
    ;MouseClick, left,  710,  122 ;beginner
    MouseClick, left,  691,  145 ;intermediate
    Sleep, 1000
    MouseClick, left,  765,  570 ;invite my own teammates
    Sleep, 2000
    MouseClick, left,  781,  439 ;invite
    Sleep, 2000
    MouseClick, left,  722,  168 ;click on text box
    Sleep, 500
    Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
    Sleep, 500
    Send, %summoner1%   ;type in summoner1's name
    Sleep, 500
    MouseClick, left,  902,  157 ;add to invite list
    Sleep, 500
    MouseClick, left,  722,  168 ;click on text box
    Sleep, 500
    Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
    Sleep, 500
    Send, %summoner2%   ;type in summoner2's name
    Sleep, 500
    MouseClick, left,  902,  157 ;add to invite list
    Sleep, 500
    MouseClick, left,  722,  168 ;click on text box
    Sleep, 500
    Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
    Sleep, 500
    Send, %summoner3%   ;type in summoner3's name
    Sleep, 500
    MouseClick, left,  902,  157 ;add to invite list
    Sleep, 500
    MouseClick, left,  722,  168 ;click on text box
    Sleep, 500
    Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
    Sleep, 500
    Send, %summoner4%   ;type in summoner4's name
    Sleep, 500
    MouseClick, left,  902,  157 ;add to invite list
    Sleep, 500
    MouseClick, left,  735,  566 ;click "Invite players"
    Sleep, 1000
    while True      ;check that first player has joined
    {
        Sleep, 500
        PixelSearch, FoundX, FoundY, 191, 389, 193, 391, 0xA2E7F9 ;search for yellow of 'x' in kick button where fifth player shows up
        if ErrorLevel ;could not find
                Sleep, 10   
        else
            break   
    }
    Sleep, 1000
    MouseClick, left, 529, 436 ;start game
    while True ;wait for queue to fire
    {
        Sleep, 1000
        PixelSearch, FoundX, FoundY, 507, 324, 509, 326, 0xFFFFFF ;look for white of timer pie
        if ErrorLevel ;could not find
                Sleep, 10   
        else
            break   
    }
    MouseClick, left, 421, 364 ;click "accept" when match is made to go to champ select
}
return

SlaveJoinGame()
{
    while True ;wait for invite
    {
        Sleep, 1000
        PixelSearch, FoundX, FoundY, 906, 559, 908, 561, 0xF4F4F4 ;look for white in "I" of "Intermediate"
        if ErrorLevel ;could not find
                Sleep, 10   
        else
            break   
    }
    MouseClick, left, 865, 590 ;accept invite
    while True ;wait for queue to fire
    { 
        Sleep, 1000
        PixelSearch, FoundX, FoundY, 507, 324, 509, 326, 0xFFFFFF ;look for white of timer pie
        if ErrorLevel ;could not find
                Sleep, 10   
        else
            break   
    }
    MouseClick, left, 421, 364 ;click "accept" when match is made to go to champ select
}
return
