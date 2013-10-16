#Include progress2.ahk

;matt's referral link: "http://signup.leagueoflegends.com/?ref=4cc4c1a9f163d487340900"
;jlosh referral link:  "http://signup.leagueoflegends.com/?ref=4df3022975a2d908834853"
;george ref link:      "http://signup.leagueoflegends.com/?ref=4dc070d8d86a0397596492"

REFLINK := "http://signup.leagueoflegends.com/?ref=4dc070d8d86a0397596492"
PASSWORD := "random17"

#s::Reload

#t::Pause

;this is a utility testing method - feel free to swap it out for whatever function
#v::
Sleep, 1000
BuyXPBoost("small")
Loop, 4
{
    DoBattleTraining()
    Sleep, 5000
}
return

#z::
AutoSmurf("styx22Marvel", PASSWORD, REFLINK)
return

#q::
return

#w::
BotGameSlave("TT")
return

#x::
Sleep, 2000
;MakeNewSmurf("myclam7", PASSWORD, REFLINK)
;SmurfSetup("myclam7", PASSWORD)
;Loop, 2
;{
;    DoBattleTraining()
;    Sleep, 5000
;}
BuyXPBoost("small")
Loop, 4
{
    DoBattleTraining()
    Sleep, 5000
}
CloseLoLClient()

AutoSmurf("tiny1xprogress", PASSWORD, REFLINK)
AutoSmurf("tiny2xprogress", PASSWORD, REFLINK)

return