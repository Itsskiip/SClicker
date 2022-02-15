#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#MaxThreadsPerHotkey 2
SetBatchLines -1
CoordMode Mouse

IniRead WaitTime, SClicker.ini, Settings, WaitTime
IniRead PollingTime, SClicker.ini, Settings, PollingTime
IniRead Hkey, SClicker.ini, Settings, Hotkey

Hotkey %Hkey%, run
Toggle := False

return

run:
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