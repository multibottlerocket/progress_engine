#NoEnv
#InstallKeybdHook
SetKeyDelay, 100, 30
;position of "lvl 3 RP reward" popup x in client: 801, 93
;position of "level up" popup x in client: 874, 93

#s::Reload

#t::Pause

;this is a utility testing method - feel free to swap it out for whatever function
#v::
;LogIn("C:\accountData.txt")
;MasterCreateGame("mytroll17", "mytroll18", "peachhichew", "greenapplehichew")
BotGameMaster()
return

#q::
WaitGameStart()
WinGameLoop()
CleanupGame()
Sleep, 60000 ;give ample time for everyone to align
BotGameMaster()
return

#w::
WaitGameStart()
WinGameLoop()
CleanupGame()
Sleep, 60000 ;give ample time for everyone to align
BotGameSlave()
return

#x::
;SlaveJoinGame()
;WinGameVisual(true) ; SelectYi() has been temporarily commented out for testing!
;SmurfSetup("C:\accountData.txt")
;DoBattleTraining()
BotGameSlave()
return

;game creator for co-op vs ai spam
BotGameMaster()
{
    while true
    {
        MasterCreateGame("TT", "peachhichew", "mytroll17", "mangohichew", "katherinewheel")
        Sleep, 10000
        SelectFirstChamp()
        WaitGameStart()
        WinGameLoop("TT")
        CleanupGame()
        Sleep, 60000 ;give ample time for everyone to align
    }
}

;game slave for co-op vs ai spam
BotGameSlave()
{
    while true
    {
        SlaveJoinGame()
        Sleep, 10000
        SelectFirstChamp()
        WaitGameStart()
        WinGameLoop("TT")
        CleanupGame()
        Sleep, 60000 ;give ample time for everyone to align
    }
}

WinGameVisual(waitLong)
{
    ;SelectYi() ; ***temporarily commented out for testing!***
    Sleep, 20000 ;open-loop wait for countdown and loading of game
    if (waitLong)
        Sleep, 90000
    WaitGameStart()
    WinGameLoopVisual()
    
    CleanupGame()
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
WinGameLoop(map)
{
    while true
    {
        if (map == "TT")
        {
            SuicideTT()
        }
        else
        {
            Suicide()
        }
        ;SkillUp()   ;removed until we know what champs we're using
        ;Abilities() ;
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

;In-game loop of pushing/shopping with visual feedback
WinGameLoopVisual()
{
    lastHealth := 100
    dangerHealth := 20 ;run away and heal if below this % health
    while true
    {
        Suicide()
        ;SkillUp()   ;removed until we know what champs we're using
        ;Abilities() ;
        ;Sleep, 500
        Send {Click 510, 416} ;click on "continue' button after defeat/victory
        IfWinExist, PVP.net Client
        {
            WinActivate
            return      
        }
        ;Sleep, 500
        health := GetHealth()
        ;in-game debug output
        ;healthXBase := 396
        ;healthDbgY := 730
        ;lastHealthDbgY := 720 
        ;Send {Enter}
        ;Send %health%
        ;Send %lastHealth%
        ;Send {Enter}
        ;end in-game debugging output
        if (health == 0) ;dead
        {
            Shop()
        }
        else if (health <= dangerHealth) ;if low, run away and b
        {
            Loop, 3 ;spam retreat (it sometimes drops on VM)
            {
                MouseClick, right, 838, 753 
                Sleep, 100
            }
            Sleep, 10000
            Send, b
            Sleep, 9000
            Shop()
        }
        else if (health < lastHealth) ;taking damage
        {
            Loop, 3 ;spam retreat (it sometimes drops on VM)
            {
                MouseClick, right, 838, 753 
                Sleep, 100
            }
            healthDiff := lastHealth - health
            if (healthDiff >= 30) ;took a lot of damage - retreat for next creep wave
                Sleep, 15000
            else
                Sleep, 3000 ;didn't take too much - just jiggle back a bit
            health := GetHealth() ;get fresh health measurement before storing
            lastHealth := health
        }
        else ;all is well
        {
            lastHealth := health
        }
    }
}

;In-game loop of pushing/shopping with visual feedback for kayle
KayleLoop()
{
    lastHealth := 100
    dangerHealth := 20 ;run away and heal if below this % health
    while true
    {
        Suicide()
        ;spam skills
        Send e ;spam auto buff
        Send d ;spam revive
        Send f ;spam ghost
        ;level up skills
        Send ^r ;skill up r
        Send ^e ;skill up w
        Send ^w ;skill up e
        Send {Click 510, 416} ;click on "continue' button after defeat/victory
        IfWinExist, PVP.net Client
        {
            WinActivate
            return      
        }
        health := GetHealth()
        if (health == 0) ;dead
        {
            Shop()
        }
        else if (health <= dangerHealth) ;if low, run away and b
        {
            Loop, 3 ;spam retreat (it sometimes drops on VM)
            {
                MouseClick, right, 838, 753 
                Sleep, 100
            }
            Send !r              ;self-ult
            Send !w              ;self-heal for good measure
            Sleep, 10000
            Send, b
            Sleep, 9000
            Shop()
        }
        else if (health < lastHealth) ;taking damage
        {
            Loop, 3 ;spam retreat (it sometimes drops on VM)
            {
                MouseClick, right, 838, 753 
                Sleep, 100
            }
            healthDiff := lastHealth - health
            if (healthDiff >= 30) ;took a lot of damage - retreat for next creep wave
            {
                Send !r              ;self-ult
                Send !w              ;self-heal for good measure
                Sleep, 15000
            }
            else
            {
                Send !w              ;self-heal
                Sleep, 3000 ;didn't take too much - just jiggle back a bit
            }
            health := GetHealth() ;get fresh health measurement before storing
            lastHealth := health
        }
        else ;all is well
        {
            lastHealth := health
        }
    }
}

;In-game loop of pushing/shopping with visual feedback for ashe
AsheLoop()
{
    lastHealth := 100
    dangerHealth := 20 ;run away and heal if below this % health
    while true
    {
        Suicide()
        ;spam skills
        Send d ;spam revive
        Send f ;spam ghost
        ;level up skills
        Send ^r ;skill up r
        Send ^w ;skill up w
        Send ^e ;skill up e
        Send {Click 510, 416} ;click on "continue' button after defeat/victory
        IfWinExist, PVP.net Client
        {
            WinActivate
            return      
        }
        health := GetHealth()
        if (health == 0) ;dead
        {
            Shop()
        }
        else if (health <= dangerHealth) ;if low, run away and b
        {
            Loop, 3 ;spam retreat (it sometimes drops on VM)
            {
                MouseClick, right, 838, 753 
                Sleep, 100
            }
            MouseMove, 610, 325 ;spam a volley as a parting gift
            Send w              ;
            MouseMove, 730, 145 ;toss an arrow out for good measure
            Send r              ;
            Sleep, 10000
            Send, b
            Sleep, 9000
            Shop()
        }
        else if (health < lastHealth) ;taking damage
        {
            Loop, 3 ;spam retreat (it sometimes drops on VM)
            {
                MouseClick, right, 838, 753 
                Sleep, 100
            }
            healthDiff := lastHealth - health
            if (healthDiff >= 30) ;took a lot of damage - retreat for next creep wave
            {
                MouseMove, 610, 325 ;spam a volley as a parting gift
                Send w              ;
                MouseMove, 730, 145 ;toss an arrow out for good measure
                Send r              ;
                Sleep, 15000
            }
            else
            {
                MouseMove, 610, 325 ;spam a volley as a parting gift
                Send w           
                Sleep, 3000 ;didn't take too much - just jiggle back a bit
            }
            health := GetHealth() ;get fresh health measurement before storing
            lastHealth := health
        }
        else ;all is well
        {
            lastHealth := health
        }
    }
}

;In-game loop of pushing/shopping with visual feedback for sivir
SivirLoop()
{
    lastHealth := 100
    dangerHealth := 20 ;run away and heal if below this % health
    while true
    {
        Suicide()
        ;spam skills
        Send w ;spam auto-booster
        Send r ;spam ult
        Send d ;spam revive
        Send f ;spam ghost
        ;level up skills
        Send ^r ;skill up r
        Send ^w ;skill up w
        Send ^e ;skill up e
        Send {Click 510, 416} ;click on "continue' button after defeat/victory
        IfWinExist, PVP.net Client
        {
            WinActivate
            return      
        }
        health := GetHealth()
        if (health == 0) ;dead
        {
            Shop()
        }
        else if (health <= dangerHealth) ;if low, run away and b
        {
            Loop, 3 ;spam retreat (it sometimes drops on VM)
            {
                MouseClick, right, 838, 753 
                Sleep, 100
            }
            Send e ;randomly try to spell shield and get lucky
            Sleep, 10000
            Send, b
            Sleep, 9000
            Shop()
        }
        else if (health < lastHealth) ;taking damage
        {
            Loop, 3 ;spam retreat (it sometimes drops on VM)
            {
                MouseClick, right, 838, 753 
                Sleep, 100
            }
            healthDiff := lastHealth - health
            if (healthDiff >= 30) ;took a lot of damage - retreat for next creep wave
            {
                Send e ;randomly try to spell shield and get lucky
                Sleep, 15000
            }
            else
            {
                Sleep, 3000 ;didn't take too much - just jiggle back a bit
            }
            health := GetHealth() ;get fresh health measurement before storing
            lastHealth := health
        }
        else ;all is well
        {
            lastHealth := health
        }
    }
}

;returns true if 0 minutes found, or false otherwise
CleanupGame()
{
    StatsCheck()
    Send {Click 700, 590} ;click on 'return to lobby' button 
    Sleep, 5000
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
}


Suicide()
{
    Send {a} ;issue attack move command
    Sleep, 200
    Send {Click 1011, 598}  ; click on enemy fountain via minimap
    Sleep, 300
}

;suicide through bot lane on TT
SuicideTT()
{
    Send {a} ;issue attack move command
    Sleep, 200
    Send {Click 992, 669}  ; click on enemy fountain via minimap
    Sleep, 300
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
    return username
}

MasterCreateGame(map, summoner1, summoner2, summoner3, summoner4)
{
    MouseClick, left,  511,  35 ;click orange "Play" button
    Sleep, 2000
    MouseClick, left,  278,  139 ;co-op vs ai
    Sleep, 1000
    MouseClick, left,  393,  119 ;classic
    Sleep, 1000
    if (map == "SR")
    {
        MouseClick, left,  592,  137 ;summoner's rift
    }
    else if (map == "TT")
    {
        MouseClick, left,  560,  160 ;twisted treeline
    }
    else ;default to SR
    {
        MouseClick, left,  592,  137 ;summoner's rift
    }
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
        PixelSearch, FoundX, FoundY, 912, 536, 912, 536, 0xFBFBFB ;look for white in "-" of "co-op"
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

SmurfSetup(accountData) ;fill out referral form on website - make sure captcha is typed in first!
{
    smurfName := LogIn(accountData)
    MouseClick, left,  470,  392 ;click name entry box
    Sleep, 500
    Send, %smurfName%
    MouseClick, left,  494,  451 ;confirm name entry
    Sleep, 5000
    MouseClick, left,  365,  327 ;select summoner icon
    Sleep, 1000
    MouseClick, left,  775,  430 ;confirm icon
    Sleep, 2000
    MouseClick, left,  311,  320 ;pick noob tier
    Sleep, 2000
    MouseClick, left,  724,  439 ;confirm tier
    Sleep, 2000
    MouseClick, left,  555,  405 ;decline tutorial
    Sleep, 1000
    MouseClick, left,  555,  405 ;decline battle trainig
    Sleep, 3000
    ;CloseLoLClient()
    return
}

DoBattleTraining() ;run battle training automatically
{
    MouseClick, left,  510,  35 
    Sleep, 2000
    MouseClick, left,  278,  233
    Sleep, 2000
    MouseClick, left,  390,  165
    Sleep, 2000
    MouseClick, left,  679,  542
    Sleep, 2000
    MouseClick, left,  657,  384
    Sleep, 2000
    MouseClick, left,  651,  384
    Sleep, 2000
    MouseClick, left,  285,  243
    Sleep, 2000
    MouseClick, left,  348,  381
    Sleep, 2000
    MouseClick, left,  300,  371
    Sleep, 2000
    MouseClick, left,  358,  370
    Sleep, 2000
    MouseClick, left,  424,  382
    Sleep, 2000
    MouseClick, left,  256,  167
    Sleep, 2000
    MouseClick, left,  392,  331
    Sleep, 2000
    MouseClick, left,  742,  488
    Sleep, 2000
    MouseClick, left,  502,  429
    Sleep, 2000
    MouseClick, left,  466,  167
    Sleep, 2000
    MouseClick, left,  519,  179
    Sleep, 2000
    MouseClick, left,  366,  380
    Sleep, 2000
    MouseClick, left,  384,  421
    Sleep, 2000
    MouseClick, left,  386,  390
    Sleep, 2000
    MouseClick, left,  627,  535
    Sleep, 2000
    MouseClick, left,  862,  391
    Sleep, 2000
    MouseClick, left,  701,  400
    Sleep, 120000 ;big pause here to count down and let game load
    Loop, 5 ;this click drops sometimes, so spam it
    {
        MouseClick, left,  595,  396 ;click 'Continue' button
        Sleep, 200
    }
    Sleep, 50000 ;long pause while lady talks
    MouseClick, left,  987,  157 ;move mouse cursor over seconday quests
    Sleep, 5000
    MouseClick, left,  1016,  503 ;click hint above minimap
    Sleep, 3000
    MouseClick, left,  680,  481 ;close hint window
    Sleep, 20000 ;wait for lady to talk
    startTime := A_Now
    while true ;spam right clicks for 19 minutes, then surrender and click continue button
    {
        Send {Click right 300, 350}
        Sleep, 5000
        Send {Click right 300, 500}
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

        Send {Click 510, 416} ;click on "continue' button after defeat
        Sleep, 120000 ;let game close and pvp.net client load
    MouseClick, left,  645,  387 ;click continue on post battle screen
    Sleep, 2000
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
    MouseClick, left,  432,  313 ;click continue for ip
    Sleep, 2000
    MouseClick, left,  725,  592 ;click 'home'
    Sleep, 2000
    MouseClick, left,  561,  403 ;decline co op vs ai inv
    Sleep, 2000
    MouseClick, left,  561,  403 ;decline co op vs ai inv again
    Sleep, 2000 
    ;should be back at lobby again
    ;BuyMasterYi()

return
}

GetHealth()
{
    healthXBase := 396
    healthY := 740
    Loop, 11
    {
        healthX := healthXBase + (A_index-1)*25 ;health bar is ~250 pixels wide
        PixelSearch, FoundX, FoundY, healthX, healthY, healthX, healthY, 0x000000, 32 ;look for black-ish pixel
        if (ErrorLevel and A_index < 11) ;pixel was not black and we're not at the end
        {
            continue
        }
        else if (ErrorLevel) ;pixel was not black and we're at the end of the health bar
        {
            health := 100
            break
        }
        else ;pixel was black, so we found the end of the green
        {
            health := 10*(A_index-1)
            break
        }
    }
    return health
}