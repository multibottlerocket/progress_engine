;delays should be increased for slower computers, ideally all parameterized to one variable
;# = windows key; press it with whatever letter to start that function

#p::Pause ;useful to stop all that clicking when you're done

#s:: ;this will just spam right clicks - useful for afking in game
while true
{
	Send {Click right 600, 350}
	Sleep, 5000
	Send {Click right 600, 500}
	Sleep, 5000
}
return

#w::  ; this is the main progress engine loop
while true
{
;starts from LoL client lobby
	Send {Click 650, 50} ;click 'Play' button
	Sleep, 2000
	Send {Click 300, 220};click 'Custom' button
	Sleep, 2000
	Send {Click 1000, 700};Create Game
	Sleep, 2000
	Send {Click 500, 600};select game name entry box
	Sleep, 2000
	Send {z 4} ;add random stuff for name
	Send {r 2}
	Send {e 2}
	Sleep, 2000
	Send {Click 440, 650} ;and for password
	Send {z 4}
	Send {r 2}
	Send {e 2}
	Sleep, 3000
	Send {Click 250, 725} ;go to add bots screen
	Sleep, 2000
	Send {Click 980, 120} ;click 'x' on rune alert
    Sleep, 1000    	
	Send {Click 1100, 120} ;click 'x' on level up alert
    Sleep, 1000
	Send {Click 850, 170} ;add random bot
	Sleep, 2000
	Send {Click 900, 500} ;go to champ select
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
	Send {Click 1020, 735} ;click on 'return to lobby' button 
	Sleep, 1000
}
return	

#q::Send {Click right 1020, 735} ;for testing where stuff clicks
