#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#MaxThreadsPerHotkey 2
SetBatchLines -1

WaitTime := 100 ;How long the mouse has to be stationary for before a click is registered in miliseconds
PollingTime := 10 ;How often the script checks for mouse movement in miliseconds

Toggle := False

F10:: ;The hotkey to toggle the script
ClickedAlready := True
Toggle := !Toggle
Loop {
	If not Toggle
		break
	

	if (!MouseMoved(PollingTime)){
		if (!ClickedAlready and !MouseMoved(WaitTime - PollingTime)){
			ClickedAlready := True
			Click
		}
	} else {
		ClickedAlready := False
	}
}
return

MouseMoved(delay){
	MouseGetPos, X1, Y1
	Sleep % delay
	MouseGetPos, X2, Y2
	return (X1 != X2) or (Y1 != Y2)
}