#Requires AutoHotkey v2.0

; Create the GUI
MyGui := Gui()
MyGui.Title := "AHK v2 Key Remapper"

; Add input fields
MyGui.Add("Text", "x10 y10 w200", "Enter key combination:")
keyCombo := MyGui.Add("Hotkey", "x10 y30 w200 vKeyCombo")

MyGui.Add("Text", "x10 y60 w200", "Enter text to insert:")
textInput := MyGui.Add("Edit", "x10 y80 w200 h60 vTextInput")

; Add a button to create the hotkey
MyGui.Add("Button", "x10 y150 w100", "Create Hotkey").OnEvent("Click", CreateHotkey)

; Show the GUI
MyGui.Show()

; Function to create the hotkey and save it to remap.ahk
CreateHotkey(*)
{
    submitted := MyGui.Submit()
    combo := submitted.KeyCombo
    text := submitted.TextInput
    
    if (combo != "" and text != "") {
        ; Create the hotkey
        Hotkey(combo, (*) => SendInput(text))
        
        ; Save the hotkey to remap.ahk with proper string formatting
        FileAppend("`n" . combo . "::SendInput(" . Chr(34) . text . Chr(34) . ")", "remap.ahk")
        
        MsgBox("Hotkey created and saved: " . combo . " will insert: " . text)
    } else {
        MsgBox("Please enter both a key combination and text.")
    }
}