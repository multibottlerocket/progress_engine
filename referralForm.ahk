;george ref link:      "http://signup.leagueoflegends.com/?ref=4dc070d8d86a0397596492"

#v::FillReferralForm("random17", "http://signup.leagueoflegends.com/?ref=4dc070d8d86a0397596492")

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
    MouseClick, left,  691,  587 ; agree to terms of use (heh)
    Sleep, 300
    MouseClick, left,  696,  605 ; un-sign up for newsletter
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