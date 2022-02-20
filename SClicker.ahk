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
Menu, Tray, Icon, Red.ico

return

run:
ClickedAlready := True
Toggle := !Toggle

if Toggle
	Menu, Tray, Icon, Green.ico
else {
	Menu, Tray, Icon, Red.ico
	return
}
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