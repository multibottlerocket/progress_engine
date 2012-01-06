#NoEnv
#InstallKeybdHook
SetKeyDelay, 100, 30
SetWorkingDir, C:\Users\Jon\Documents\Code\progress_engine ;put script and other files here

#p::Pause

#w::
Send, {PRINTSCREEN}
WinWait, Untitled - Paint, 
IfWinNotActive, Untitled - Paint, , WinActivate, Untitled - Paint, 
WinWaitActive, Untitled - Paint, 
Send, {CTRLDOWN}v{CTRLUP}
Sleep, 300
MouseClick, left,  148,  81
Sleep, 300
MouseClickDrag, left, 137,  292, 12, 261, 5
Sleep, 300
Send, {CTRLDOWN}x{CTRLUP}
Sleep, 300
Send, {CTRLDOWN}n{CTRLUP}
Sleep, 300
Send, {RIGHT}{ENTER}
WinWait ahk_class MSPaintApp
IfWinNotActive ahk_class MSPaintApp, WinActivate ahk_class MSPaintApp
WinWaitActive ahk_class MSPaintApp
Send, {CTRLDOWN}v{CTRLUP}
return
