#NoEnv
#InstallKeybdHook
SetKeyDelay, 30, 30

;delays should be increased for slower computers, ideally all parameterized to one variable
;# = windows key; press it with whatever letter to start that function

#p::Pause ;useful to stop all that clicking when you're done

#b::
Suicide()
Shop()
SkillUp()
Abilities()
return

SelectTrist()
{
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
Send {Click 900, 500} ;start game
Sleep, 2000
Send {click 581, 501} ;select random if no trist
return
}

Shop()
{
Send {p} ;open shop
Sleep, 500
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
Send {Esc} ;close shop
Sleep, 500
return
}

Abilities()
{
Send {q} ;AS boost
Sleep, 500
Send {f} ;promote
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
	Send {Click 850, 170} ;add random bot
	Sleep, 2000
	Send {Click 900, 500} ;go to champ select
    Sleep, 5000
}
return

#w::  ; this is the main progress engine loop for an account with trist	
while true
{
;starts from LoL client lobby
    CreateCustomGame()
    SelectTrist()
    Sleep, 100000 ;wait for loading screen to come up before spamming
    startTime := A_Now
	while true
	{
        Suicide()
        Shop()
        SkillUp()
        Abilities()
    	Send {Click 600, 500} ;click on "continue' button after defeat
    	Sleep, 15000
        IfWinExist, PVP.net Client
        {
            WinActivate
            break        
        }
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
