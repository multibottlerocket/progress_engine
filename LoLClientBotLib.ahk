; Bot operations that deal with the LoL client, specifically tailored for
; VM's running at 1024x768

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