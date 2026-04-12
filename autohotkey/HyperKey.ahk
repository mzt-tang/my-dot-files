#Requires AutoHotkey v2.0
A_IconTip := "HyperKey Script"
SetCapsLockState "AlwaysOff"

; ---------------------------------------------------------
; 1. THE HOLD (Modifiers Down)
; ---------------------------------------------------------
*CapsLock::
{
    Send "{Blind}{LCtrl Down}{LShift Down}{LAlt Down}{LWin Down}"
}

; ---------------------------------------------------------
; 2. THE RELEASE (Modifiers Up)
; ---------------------------------------------------------
*CapsLock up::
{
    Send "{Blind}{LCtrl Up}{LShift Up}{LAlt Up}{LWin Up}"
}

; ---------------------------------------------------------
; 3. THE SHORTCUTS
; ---------------------------------------------------------
; Hyper + C: Toggle Caps Lock
^+!#c::
{
    if GetKeyState("CapsLock", "T")
        SetCapsLockState "Off"
    else
        SetCapsLockState "On"
}

^+!#d:: return  ; Show desktop
^+!#e:: return  ; File Explorer
^+!#l:: return  ; Lock screen
^+!#r:: return  ; Run dialog
^+!#s:: return  ; Search
^+!#t:: return  ; Taskbar cycling
^+!#i:: return  ; Settings
^+!#a:: return  ; Action Center
^+!#n:: return  ; Notification Center
^+!#k:: return  ; Connect
^+!#p:: return  ; Project/display modes
^+!#x:: return  ; Quick link menu
^+!#Space::  ; Hyper+Space: toggle WezTerm scratchpad
{
    if WinExist("ahk_exe wezterm-gui.exe") {
        if WinActive("ahk_exe wezterm-gui.exe") {
            WinHide "ahk_exe wezterm-gui.exe"
        } else {
            WinShow "ahk_exe wezterm-gui.exe"
            WinActivate "ahk_exe wezterm-gui.exe"
            ; Move to monitor 2 if available, then maximize
            if MonitorGetCount() >= 2 {
                MonitorGet(2, &ML, &MT, , )
                WinMove ML + 1, MT + 1, , , "ahk_exe wezterm-gui.exe"
            }
            WinMaximize "ahk_exe wezterm-gui.exe"
        }
    } else {
        Run 'C:\Program Files\WezTerm\wezterm-gui.exe'
    }
}

; ---------------------------------------------------------
; 4. LINE NAVIGATION (like Cmd+Arrow on Mac)
; ---------------------------------------------------------
; Exclude WezTerm — terminal handles these natively via keybindings
#HotIf !WinActive("ahk_exe wezterm-gui.exe")
!Left::Send("{Home}")
!Right::Send("{End}")
!BackSpace::Send("+{Home}{Delete}")   ; Delete to start of line (like Cmd+Backspace on Mac)
!Delete::Send("+{End}{Delete}")       ; Delete to end of line (like Cmd+Delete on Mac)
#HotIf
