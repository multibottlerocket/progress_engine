#NoEnv
#InstallKeybdHook
#Include tf.ahk
SetKeyDelay, 100, 30
;position of "lvl 3 RP reward" popup x in client: 801, 93
;position of "level up" popup x in client: 874, 93
;matt's referral link: "http://signup.leagueoflegends.com/?ref=4cc4c1a9f163d487340900"
;jlosh referral link:  "http://signup.leagueoflegends.com/?ref=4df3022975a2d908834853"
;aerial referral link: "http://signup.leagueoflegends.com/?ref=4e0d1472cd21a929683971"
;george ref link:      "http://signup.leagueoflegends.com/?ref=4dc070d8d86a0397596492"
;josh ref link:        "http://signup.leagueoflegends.com/?ref=525b4f68a0b5a519065718"
;tiffany ref link:     "http://signup.leagueoflegends.com/?ref=525b5a8594184160217873"
;golf ref link:        "http://signup.leagueoflegends.com/?ref=525f7133f4190108692822"
;spamninja ref link:   "http://signup.leagueoflegends.com/?ref=4ce0a8276d57a105645474"

;TODO's:
;"OK" for in-game afk notification that exits game 617, 472
;I think bug splats for battle training don't give you the orange "reconnect" button - 
;   they just put you on the normal client screen
; add lvl 10 support (250 RP XP boost, lvl 10 picture)
; relog after every game to refresh RP? (lvl 3 bug)

globalGameLogic := "INTRO_AHK"
globalAccountSourceType := "LIST"

georgeReflink := "4dc070d8d86a0397596492" ;george
;globalReflink := "4ce0a8276d57a105645474" ;spam ninja
;globalReflink := "52d82c79c1c55823529937" ;vimmmmm
;globalReflink := "4e0d1472cd21a929683971" ;aerial
globalReflink := "4df3022975a2d908834853" ;jlosh
;globalReflink := "52ee65df8d405041134169" ;andykat1
;globalReflink := "52ee661a7fee1529378415" ;andykat2
#s::Reload

#t::Pause

;this is a utility testing method - feel free to swap it out for whatever function
#v::
CheckForPlayButton()
;RedeemSmurfs()
return

#z::
;Sleep, 120000
while true {
    AutoSmurf("random17", globalGameLogic, globalAccountSourceType, 10, globalReflink)
}
return

#q::
while true {
    AutoSmurf("random17", globalGameLogic, globalAccountSourceType, 5, georgeReflink)
}
;CheckIfRich()

return

#w::
while true
{
    Sleep, 10000
    WinGameLoop("SR")
    IfWinExist, PVP.net Client
    {
        WinActivate
        break      
    }
}
CleanupGame()
Sleep, 10000
while true {
    AutoSmurf("random17", globalGameLogic, globalAccountSourceType, 10, georgeReflink)
}
return

;clean out current smurf state
#x::
smurfName := "smurfTest"
password := "random17"
CleanupSmurf("None", password, globalReflink)
return

;TODO: add timeouts that restart lol client and game if we've been locked in one state for too long
AutoSmurf(password, inGameLogic, accountSource, smurfLevel, reflink = "None") 
{
    refCode := SubStr(reflink, -3) ; get last 4 digits of reflink to identify who the smurf is for
    currentSmurf := "C:\currentSmurf" . refCode . ".txt"
    FileReadLine, smurfName, %currentSmurf%, 1 ;get current smurf name, stored locally
    if ErrorLevel ;currentSmurf.txt does not exist, so create it
    {
        FileAppend, None, %currentSmurf% ;first line stores name of smurf
        FileAppend, `nNone, %currentSmurf% ;second line stores password of smurf
        smurfName = "None"
    }
    if (smurfName == "None") ; get new smurf
    {
        ;get smurf index from global smurf index file
        refCode := SubStr(reflink, -3)
        if (accountSource == "AUTOMATIC") { ; only works if the auto account maker/captcha breaker is operational
            ;append smurf index to username base
            Random, smurfRand, 1000000, 9999999
            smurfName := "Prisoner" . smurfRand 
            MakeNewSmurf(smurfName, password, reflink)
            ;ugh i really want feedback on whether an account got created successfully
        } else if (accountSource == "LIST") {
            if (smurfLevel == 5) {
                smurfList := "smurfListRefCode" . refCode ".txt" ; put fresh accounts in file with this name
                PopAccountData(smurfList, smurfName, password)
            }
            else if (smurfLevel == 10) {
                smurfList := "smurfListLvl10RefCode" . refCode ".txt" ; put fresh accounts in file with this name
                PopAccountData(smurfList, smurfName, password)
            }
            else {
                MsgBox, "Error: smurfLevel not supported!"
            }
        } else {
            MsgBox, "Error: accountSource not supported!"
        }

        SmurfSetup(smurfName, password)
        TF_ReplaceLine("!" . currentSmurf, "1", "1", smurfName) ;store current smurfs login info
        TF_ReplaceLine("!" . currentSmurf, "2", "2", password)
    }
    else ;resume where we left off
    {
        FileReadLine, smurfName, %currentSmurf%, 1
        FileReadLine, password, %currentSmurf%, 2
        LogIn(smurfName, password)
    }
    if CheckIfOne()
    {
        DoBattleTraining()
        if (inGameLogic == "BOT_OF_LEGENDS") {
            BuyChamp("ryze") 
        }
        else {
            BuyChamp("sivir") 
        }
    }
    if (smurfLevel == 5) {
        while not CheckIfFive()
        {
            if CheckIfRich()
            {
                BuyXPBoost()
            }
            if (inGameLogic == "INTRO_AHK") {
                BotGameFarm("intro", inGameLogic)
            }
            else if (inGameLogic == "BOT_OF_LEGENDS") {
                BotGameFarm("beginner", inGameLogic)
            }
            else if (inGameLogic == "BATTLE_TRAINING") {
                DoBattleTraining()
            }
            else { ;revert to battle training as safest case
                DoBattleTraining() 
            }
            Sleep, 5000
        }
    } else if (smurfLevel == 10) {
        while not CheckIfTen()
        {
            if CheckIfRich()
            {
                BuyXPBoost()
            }
            if Check250RP()
            {
                BuyXPBoost()
            }
            if (inGameLogic == "INTRO_AHK") {
                BotGameFarm("intro", inGameLogic)
            }
            else if (inGameLogic == "BOT_OF_LEGENDS") {
                BotGameFarm("beginner", inGameLogic)
            }
            else if (inGameLogic == "BATTLE_TRAINING") {
                DoBattleTraining()
            }
            else { ;revert to battle training as safest case
                DoBattleTraining() 
            }
            Sleep, 5000
        }        
    }
    ;we're done, so do some cleanup
    TF_ReplaceLine("!" . currentSmurf, "1", "1", "None") ;indicate we're not currently doing a smurf
    TF_ReplaceLine("!" . currentSmurf, "2", "2", "None")
    CloseLoLClient()
    Sleep, 5000
    return
}

CleanupSmurf(smurfName, password, reflink) ;clean up state
{
    refCode := SubStr(reflink, -3)
    currentSmurf := "C:\currentSmurf" . refCode . ".txt"
    TF_ReplaceLine("!" . currentSmurf, "1", "1", "None") ;locally indicate we're not currently doing a smurf
    TF_ReplaceLine("!" . currentSmurf, "2", "2", "None")
}



BotGameFarm(difficulty, inGameLogic)  ;i wouldn't recommend anything besides intro
{
    map = "SR"
    joinGame:
    JoinSoloBotGame(map, difficulty)
    if (inGameLogic == "INTRO_AHK") {
        SelectChamp("sivir")
    }
    else if (inGameLogic == "BOT_OF_LEGENDS") {
        SelectChamp("ryze")
    }
    else { ; revert to safest champ
        SelectChamp("sivir")
    }
    Sleep, 90000
    IfWinExist ahk_class RiotWindowClass ;if game launches, focus on it
    {
        WinActivate
    }   
    else {
        CloseChrome()
        IfWinExist, PVP.net Client
        {
            WinActivate
        }
        ViewProfile()
        Sleep, 5000
        MouseClick, left, 512, 363 ;dismiss queue dodge warning safely
        Sleep, 1000
        MouseClick, left, 985, 50 ;horrible kludge to get rid of skin screen - don't ask
        Goto, joinGame
    }
    WaitGameLoad()
    Sleep, 90000 ; wait until minions spawn to do shit
    if (inGameLogic == "INTRO_AHK") {
        WinGameLoop(map)
    }
    else if (inGameLogic == "BOT_OF_LEGENDS") {
        BoLLoop()
        CleanupGame()
    }
    else { ; revert to safest champ
        WinGameLoop(map)
    }
    Sleep, 10000
}

;waits for all summoners to load
WaitGameLoad() {
    while true
    {
        Sleep, 3000
        PixelSearch, FoundX, FoundY, 504, 382, 504, 382, 0x599ED5 ;look for bright gold in "V" of "VS"
        if ErrorLevel ;could not find, hopefully we're in the game now
            break
        else
            Sleep, 10   
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
        ClickEndGameContinue()
        IfWinExist, PVP.net Client
        {
            WinActivate
            return       
        }
    }
}

;In-game loop of pushing/shopping.
WinGameLoop(map) {
    while true
    {
        Suicide(map)
        ;SkillUp()   ;removed until we know what champs we're using
        ;Abilities() ;
        Sleep, 1000
        ClickEndGameContinue()
        IfWinExist, Error Report ; check for bug splat
        {
            WinActivate
            Sleep, 1000
            MouseClick, left, 215, 401 ;dismiss bug splat 
        }
        CoordMode, Mouse, Screen
        MouseClick, left, 878, 753 ; click client in system tray
        CoordMode, Mouse, Relative
        IfWinExist, PVP.net Client
        {
            WinActivate
            Sleep, 5000
            if CheckForReconnect()
            {
                MouseClick, left, 518, 364 ;click reconnect
                Sleep, 60000 ; let game load
                continue
            }
            CleanupGame() ; no reconnect, so game must be done
            return      
        }
        Sleep, 2000
        Shop(map)
    }
}

;In-game logic when using bot of legends
BoLLoop() {
    while true
    {
        ;Shop("SR")
        Sleep, 10000
        ClickEndGameContinue()
        IfWinExist, PVP.net Client
        {
            WinActivate
            break      
        }
    }
}



CleanupGame()
{
    ; keep clicking 'return to lobby' button until we see the red of the "Play" button
    while true
    {
        Send {Click 700, 590} ;click on 'return to lobby' button 
        Sleep, 5000
        CloseChrome()
        IfWinExist, PvP.net Client
        {
            WinActivate
        }
        ViewProfile()
        Sleep, 2000
        MouseClick, left,  561,  403 ;decline co op vs ai inv
        Sleep, 1000
        MouseClick, left,  561,  403 ;decline co op vs ai inv again
        if CheckForPlayButton()
        {
            break
        }
        else
        {
            Sleep, 1000
        }
    }

}

Retreat(map)
{
    if (map == "SR")
    {
        MouseClick, right, 838, 753
        Sleep, 100
    }
    else if (map == "TT")
    {
        MouseClick, right, 847, 676
        Sleep, 100
    }
}

Suicide(map)
{
    Send {a} ;issue attack move command
    Sleep, 200
    if (map == "SR")
    {
        MouseClick, left, 1011, 598
    }
    else if (map == "TT")
    {
        MouseClick, left, 992, 685
    }
    else {
        MouseClick, left, 1011, 598        
    }
    Sleep, 300
}

ClickEndGameContinue() {
    Send {Click 522, 562} ;click on "continue' button after defeat/victory
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
}

Shop(map)
{
    ;MouseClick, left, 137,  754 ;click to open shop
    ;Sleep, 100
    ;MouseClick, left, 137,  754 ;click to open shop
    ;Sleep, 100
    MouseClick, left, 137,  754 ;click to open shop
    Sleep, 1000
    if (map == "SR")
    {
        Send, {CTRLDOWN}l{CTRLUP}do
        Sleep, 500
        MouseClick, left,  380, 240 ;select doran's blade
        Sleep, 300
        MouseClick, left, 813, 464 ;try to buy doran's blade
        MouseClick, left, 813, 464 ;
        MouseClick, left, 813, 464 ;
        MouseClick, left, 813, 464 ;
    }
    else if (map == "TT")
    {
        Send, {CTRLDOWN}l{CTRLUP}do
        Sleep, 500
        MouseClick, left,  380, 240 ;select doran's blade
        Sleep, 300
        MouseClick, left, 813, 464 ;try to buy doran's blade
        MouseClick, left, 813, 464 ;
        MouseClick, left, 813, 464 ;
        MouseClick, left, 813, 464 ;
    }
    else {
        Send, {CTRLDOWN}l{CTRLUP}do
        Sleep, 500
        MouseClick, left,  380, 240 ;select doran's blade
        Sleep, 300
        MouseClick, left, 813, 464 ;try to buy doran's blade
        MouseClick, left, 813, 464 ;
        MouseClick, left, 813, 464 ;
        MouseClick, left, 813, 464 ;
    }
    Sleep, 300
    MouseClick, left,  923, 64 ;click to close shop
    Sleep, 100
}

SelectFirstChamp()
{
    Send {click 274, 174} ;click on top left champ space
    Sleep, 2000
    Send {Click 702, 410} ;attempt to start game
    Sleep, 30000 ;wait for load screen to pop up if successful
}

SelectChamp(champName)
{
    Send {Click 731, 110} ;click on search box
    Sleep, 500
    Send, %champName%
    Sleep, 1000
    Send {click 274, 174} ;click on top left champ space
    Sleep, 2000
    Send {click 517, 421} ;click on summoner spells
    Sleep, 1000
    Send {click 455, 175} ;click on ghost
    Sleep, 1000
    Send {click 523, 244} ;click on barrier
    Sleep, 1000
    Send {click 583, 171} ;click on heal in case barrier is not available
    Sleep, 1000
    Send {Click 702, 410} ;attempt to ready up
    Sleep, 1000
    Send {Click 731, 110} ;click on search box (which also clears it, apparently)
    Sleep, 2000
    Send {click 274, 174} ;click on top left champ space (random)
    Sleep, 1000
    Send {Click 702, 410} ;attempt to ready up
    ;Sleep, 30000 ;wait for load screen to pop up if successful
}

CloseLoLClient()
{
    IfWinExist, PVP.net Client
    {
        WinKill
    }
    return
}

CloseLoLGame()
{
    IfWinExist, League of Legends (TM) Client
    {
        WinKill
    }
    return
}

CloseChrome()
{
    SetTitleMatchMode, 2
    IfWinExist, Google Chrome 
    {
        Process, Close, chrome.exe
    }
    return
}

JoinSoloBotGame(map, difficulty)
{
    ;MsgBox %summoner1% %summoner2%
    MouseClick, left,  511,  35 ;click orange "Play" button
    Sleep, 2000
    MouseClick, left,  278,  139 ;co-op vs ai
    Sleep, 1000
    MouseClick, left,  393,  119 ;classic
    Sleep, 1000
    if (map == "SR") {
        MouseClick, left,  592,  137 ;summoner's rift
    }
    else if (map == "TT") {
        MouseClick, left,  560,  160 ;twisted treeline
    }
    else { ;default to SR
        MouseClick, left,  592,  137 ;summoner's rift
    }
    Sleep, 1000
    if (difficulty == "intro") {
        MouseClick, left,  710,  120 ;intro
    }
    else if (difficulty == "beginner")
    {
        MouseClick, left,  710,  145 ;beginner
    }
    else if (difficulty == "intermediate")
    {
        MouseClick, left,  691,  165 ;intermediate
    }
    else ;default to intro
    {
        MouseClick, left,  691,  120 ;intro
    }
    Sleep, 1000
    MouseClick, left,  610,  570 ;solo
    Sleep, 2000
    Loop, 20 ;wait for queue to fire
    {
        Sleep, 1000
        PixelSearch, FoundX, FoundY, 507, 324, 509, 326, 0xFFFFFF ;look for white of timer pie
        if ErrorLevel ;could not find
                Sleep, 10   
        else
            break   
    }
    accept:
    MouseClick, left, 421, 364 ;click "accept" when match is made to go to champ select
    Sleep, 10000
    Loop, 20 ;catch cases where we get requeued
    {
        Sleep, 1000
        PixelSearch, FoundX, FoundY, 507, 324, 509, 326, 0xFFFFFF ;look for white of timer pie
        if ErrorLevel ;could not find, so we're good
                break   
        else
            Sleep, 2000
            Goto accept
    }
}
return

DoBattleTraining() ;run battle training automatically
{
    MouseClick, left,  510,  35 
    Sleep, 2000
    MouseClick, left,  278,  233
    Sleep, 2000
    MouseClick, left,  390,  165
    Sleep, 2000
    MouseClick, left,  679,  542
    Sleep, 20000
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
    MouseClick, left,  256,  167 ;ashe
    ;MouseClick, left,  370,  167 ;ryze is a mage
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
    Sleep, 180000 ;big pause here to count down and let game load
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
    MouseClick, left, 617, 472 ;dismiss afk window
    MouseClick, left, 617, 472 ;dismiss afk window
    startTime := A_Now
    while true ;spam right clicks for 17 minutes, then surrender and click continue button
    {
        Send {Click right 300, 350}
        Sleep, 5000
        Send {Click right 300, 500}
        Sleep, 5000
        MouseClick, left, 617, 472 ;dismiss afk window
        Sleep, 1000
        nowTime := A_Now
        EnvSub, nowTime, %startTime%, Minutes
        if (nowTime > 17) ;surrender after 17 minutes (extra time is spent waiting for lady to talk)
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
        ClickEndGameContinue()
        IfWinExist, PVP.net Client
        {
            WinActivate
            break       
        }
    }
    Sleep, 20000 ;let game close and pvp.net client load
    if CheckForPlayButton()
    {
        return ;exit training prematurely if client loads and there's the "play" button (implies it's not the game stats screen)
    }
    MouseClick, left,  645,  387 ;click continue on post battle screen
    Sleep, 2000
    CleanupGame()
    Sleep, 2000 
    ;should be back at lobby again

return
}

BuyXPBoost()
{
    MouseClick, left,  704,  40 ;open shop
    Sleep, 15000
    MouseClick, left,  67,  507 ;boosts
    Sleep, 10000
    MouseClick, left,  257,  155 ;search box
    Sleep, 100
    Send, xp
    Sleep, 1000
    MouseClick, left, 188, 369 ;sort by RP
    Sleep, 1000
    MouseClick, left, 419, 288 ;1 day boost
    Sleep, 3000
    MouseClick, left,  593,  574 ;purchase
    Sleep, 2000
}

BuyChamp(champName)
{
    MouseClick, left,  695,  40 ;shop
    Sleep, 10000
    MouseClick, left,  83,  260 ;champs
    Sleep, 5000
    MouseClick, left,  278,  156 ;search
    Sleep, 200
    Send, %champName%
    Sleep, 2000
    MouseClick, left,  406,  288 ;unlock
    Sleep, 2000
    MouseClick, left,  705,  583 ;buy with IP
    Sleep, 5000
}

LogIn(username, password) ;accountData should have account name on first line and pw on second
{
    Run, C:\Riot Games\League of Legends\lol.launcher.exe
    Sleep, 3000
    While 1
    {
        IfWinExist, Error ;silly hack to dismiss the "another instance of LoL is running" box
        {
            WinActivate
            Send {Enter}
            Break
        }
        IfWinExist, LoL Patcher
            Break
    }

    WinWait, LoL Patcher
    WinActivate
    Sleep, 10000
    Send {click 488, 29} ;click on orange "launch" button
    Sleep, 2000
    Send {click 488, 29} ;tiny XP VM sometimes misses first click

    WinWait, PVP.net Client
    WinActivate
    Sleep, 12000
    Send {click 233,  255} ;username
    Sleep, 1000
    Send {ctrl down}a{ctrl up} ;select all previously existing text to overwrite
    SendInput, %username%
    Sleep, 1000
    Send {click 239, 315} ;pw
    SendInput, %password%
    Sleep, 1000
    Send {click 276,  338} ;log in
    Sleep, 15000
    ViewProfile() ;get to safe place with no clickables
    Sleep, 1000
    MouseClick, left, 555, 378 ;dismiss mastery update notification
    ViewProfile()
    Sleep, 1000
    Send {click 1001,  87} ;dismiss overlay if it exists
    Sleep, 2000
    Send {click 1001,  87} ;so many fucking overlays
    Sleep, 3000
    Loop, 26 { ;dismiss random popup notifications
        MouseClick, left, 600+A_Index*15, 95
        Sleep, 200
    }
    return
}

;accountsFile should have account name on first line and pw on second
PopAccountData(accountsFile ;inputs
             , byRef username, byRef password) { ;outputs
    FileReadLine, username, %accountsFile%, 1
    FileReadLine, password, %accountsFile%, 2
    TF_RemoveLines("!" . accountsFile, 1, 2)
}

MakeNewSmurf(username, password, reflink)
{
    run C:\Program Files\Google\Chrome\Application\chrome.exe
    SetTitleMatchMode, 2 ;look for windows that merely contain "google chrome"
    WinWait, Google Chrome, 
    IfWinNotActive, Google Chrome, , WinActivate, Google Chrome, 
    WinWaitActive, Google Chrome, 
    Sleep, 35000
    ;Send, {CTRLDOWN}l{CTRLUP}wg741.webgate.pl{ENTER}
    Send, {CTRLDOWN}l{CTRLUP}http://arcane-escarpment-5381.herokuapp.com/index.php{ENTER}
    Sleep, 15000
    MouseClick, left,  340,  208 ;reflink box
    Sleep, 100
    Send, %reflink%
    MouseClick, left,  334,  254
    Sleep, 100
    Send, {CTRLDOWN}a{CTRLUP}%username%
    MouseClick, left,  325,  283
    Sleep, 100
    Send, {CTRLDOWN}a{CTRLUP}%password%
    MouseClick, left,  233,  341
    Sleep, 100
    Random, day, 1, 28
    Send, {CTRLDOWN}a{CTRLUP}%day%
    MouseClick, left,  300,  345
    Sleep, 100
    Random, month, 1, 12
    Send, {CTRLDOWN}a{CTRLUP}%month%
    MouseClick, left,  384,  345
    Sleep, 100
    Random, year, 1981, 1992
    Send, {CTRLDOWN}a{CTRLUP}%year%
    MouseClick, left,  261,  387 ;create!
    Sleep, 30000 ;wait for account to create
    ;add new account to smurf list
    IfWinExist, Google Chrome
    {
        WinKill
    }
}

FillReferralForm(password, reflinkURL) {
    Random, nameSuffix, 10000000, 99999999
    Random, month, 1, 12
    Random, day, 1, 28
    Random, year, 1981, 1992
    username := "Prisoner" . nameSuffix
    Clipboard = %reflinkURL% ; put URL on clipboard for faster entry

    Send, {CTRLDOWN}l{CTRLUP} ; select address bar
    Sleep, 100
    Send, {CTRLDOWN}a{CTRLUP}{CTRLDOWN}v{CTRLUP}{ENTER} ; go to signup page
    Sleep, 3000
    MouseClick, left,  722,  301 ; select username box
    Sleep, 100
    Clipboard = %username%
    Send, {CTRLDOWN}v{CTRLUP}{TAB}
    Clipboard = %password%
    Send, {CTRLDOWN}v{CTRLUP}{TAB}{CTRLDOWN}v{CTRLUP}{TAB}
    Clipboard = %username%@gmail.com
    Send, {CTRLDOWN}v{CTRLUP}{TAB}%month%{TAB}%day%{TAB}%year%
    Sleep, 300
    MouseClick, left,  691,  580 ; agree to terms of use (heh)
    Sleep, 300
    MouseClick, left,  696,  602 ; un-sign up for newsletter
    Sleep, 300
    MsgBox, "Input captcha, then dismiss this box"
    Sleep, 300
    MouseClick, left,  858,  677 ; create account
    Sleep, 100
    ; add new accounts info to fresh account list
    freshAccountList := "smurfListRefCode" . refCode := SubStr(reflinkURL, -3) . ".txt"
    FileAppend, `n%username%, %freshAccountList%
    FileAppend, `n%password%, %freshAccountList%
}

RedeemSmurfs() { ;redeem the IP bonus from completed smurfs - must be already logged into lol website
    Clipboard = http://rewards.na.leagueoflegends.com/ ; put URL on clipboard for faster entry

    while true
    {
        Send, {CTRLDOWN}l{CTRLUP} ; select address bar
        Sleep, 100
        Send, {CTRLDOWN}a{CTRLUP}{CTRLDOWN}v{CTRLUP}{ENTER} ; go to rewards page
        Sleep, 5000
        Loop, 4
        {
            Sleep, 2000
            MouseClick, left, 924, 678
        }
        Sleep, 500
    }
}

SmurfSetup(username, password) ; do setup for accounts that have never logged in before
{
    smurfName := LogIn(username, password)
    MouseClick, left,  470,  392 ;click name entry box
    Sleep, 500
    Send, %username%
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
    MouseClick, left,  555,  405 ;decline battle training
    Sleep, 1000
    ;CloseLoLClient()
    return
}

ViewProfile() { ; a safe place where there are less evil hyperlinks that will derail the engine
    MouseClick, left, 842, 43
}

CheckIfOne() ;check if acct is level 1 ;make sure you have level1.png from the git repository in your working directory
{
    ViewProfile()
    Sleep, 5000
    MouseClick, left, 512, 363 ;dismiss "Unexpected Platform Error" if  it comes up
    Sleep, 2000
    ImageSearch, FoundX, FoundY, 350, 250, 436, 276, level1.png ;scan for "level 5" with image
    if ErrorLevel ;could not find
    {
        ;MsgBox, not found
        return false    
    }
    else
    {
        ;MsgBox, found
        return true
    }
    return
}

CheckIfFive() ;check if acct is level 5 ;make sure you have level5.png from the git repository in your working directory
{
    ViewProfile()
    Sleep, 5000
    MouseClick, left, 648, 207 ;dismiss out of place level up notification
    Sleep, 1000
    MouseClick, left, 512, 363 ;dismiss "Unexpected Platform Error" if  it comes up
    Sleep, 2000
    ImageSearch, FoundX, FoundY, 350, 250, 436, 276, level5.png ;scan for "level 5" with image
    if ErrorLevel ;could not find
    {
        ;MsgBox, not found
        return false    
    }
    else
    {
        ;MsgBox, found
        return true
    }
    return
}

CheckIfTen() ;check if acct is level 10 ;make sure you have level10.png from the git repository in your working directory
{
    ViewProfile()
    Sleep, 5000
    MouseClick, left, 512, 363 ;dismiss "Unexpected Platform Error" if  it comes up
    Sleep, 2000
    ImageSearch, FoundX, FoundY, 350, 250, 436, 276, level10.png ;scan for "level 10" with image
    if ErrorLevel ;could not find
    {
        ;MsgBox, not found
        return false    
    }
    else
    {
        ;MsgBox, found
        return true
    }
    return
}


CheckIfRich() ;check if acct has 400 RP for XP boost ;make sure you have 400RP.png from the git repository in your working directory
{
    ImageSearch, FoundX, FoundY, 840, 12, 870, 24, 400RP2.png ;scan RP with image
    if ErrorLevel ;could not find
    {
        ;MsgBox, not found
        return false    
    }
    else
    {
        ;MsgBox, found
        return true
    }
    return
}

Check250RP() ;check if acct has 250 RP for XP boost ;make sure you have 250RP.png from the git repository in your working directory
{
    ImageSearch, FoundX, FoundY, 840, 12, 870, 24, 250RP.png ;scan RP with image
    if ErrorLevel ;could not find
    {
        ;MsgBox, not found
        return false    
    }
    else
    {
        ;MsgBox, found
        return true
    }
    return
}

CheckForPlayButton()
{
    ImageSearch, FoundX, FoundY, 446, 4, 581, 64, play2.png ;scan RP with image
    if ErrorLevel ;could not find
    {
        ;MsgBox, not found
        return false    
    }
    else
    {
        ;MsgBox, found
        return true
    }
    return
}

CheckForReconnect()
{
    ImageSearch, OutputVarX, OutputVarY, 440, 351, 587, 390, reconnect.png
    if ErrorLevel ;could not find
    {
        ;MsgBox, not found
        return false    
    }
    else
    {
        ;MsgBox, found
        return true
    }
    return
}

CheckStateCounter:
;read old state counter
FileRead, oldCnt, C:\stateCounter.txt, 1
;read current state counter
FileRead, nowCnt, C:\stateCounter.txt, 2
if ErrorLevel ;stateCounter.txt does not exist, so create it
{
    FileAppend, 0, C:\stateCounter.txt ;first line stores previous state count
    FileAppend, 0, C:\stateCounter.txt ;second line stores current state count
    oldCnt := 0
    nowCnt := 1
}
if nowCnt > oldCnt ;progress churning along nicely
{
    TF_ReplaceLine("!C:\stateCounter.txt", "1", "1", nowCnt)  ;update old state counter 
}
else ;we're stalled out
{
    CloseLoLClient()
    CloseLoLGame()
    while true {
    AutoSmurf("random17", globalGameLogic, globalAccountSourceType, 5, globalReflink) ;george
    }
return
}
;   kill all LoL processes
;   restart AutoSmurf()