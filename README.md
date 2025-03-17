# AHK v2 Key Remapper

A simple AutoHotkey v2 script that creates a graphical user interface (GUI) for creating custom keyboard shortcuts that insert specified text.

## How to Use
run "scripter.ahk"

![image](https://github.com/user-attachments/assets/6052855e-62af-4aef-bc40-693e47685dd6)

enter key combo
enter desired text

![image](https://github.com/user-attachments/assets/34e8c54d-9e9c-442d-9944-d298d86f6898)

it creates a file "remap.ahk", or if it already exists: appends your shortcuts at the end.

![image](https://github.com/user-attachments/assets/83cfda20-8a33-4eee-bc88-4d54fddd474d)

💡want autostart with windows? put a shortcut to this file into your windows startup folder ( hit "Win + R" and enter "shell:startup" to find it)

to have the GUI window appear again: run the "scripter.ahk" 

## Features

- Create custom hotkeys with your desired key combinations
- Assign text to be automatically typed when the hotkey is pressed
- Saves hotkeys to a file (`remap.ahk`) for persistent use
- User-friendly GUI interface
- Validates input to ensure both key combination and text are provided
- Provides confirmation messages for successful hotkey creation

## Requirements

- [AutoHotkey v2.0](https://www.autohotkey.com/) or later installed

## Saved Hotkeys

- Hotkeys are appended to `remap.ahk` in the same directory
- To use saved hotkeys in future sessions:
  1. Run `remap.ahk` directly, or
  2. Include it in another script with `#Include remap.ahk`
- Each new hotkey is added on a new line

## Code:

```autohotkey
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


#Requires AutoHotkey v2.0

; Creates a GUI with input fields for hotkey and text
; Validates input
; Creates immediate hotkey using Hotkey()
; Saves to file with proper AHK syntax
```
