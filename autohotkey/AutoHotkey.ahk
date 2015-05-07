+CapsLock::CapsLock
CapsLock::Esc

; :ets  Edit this script.
:*::ets::
Run, "E:\Program Files (x86)\Vim\vim74\gvim" "G:\Documents\AutoHotkey.ahk"
return

; :rts Reload this script.
:*::rts::
Reload
return

; :sh   Suspend hotkeys.
:*::sh::
Suspend Toggle
return

; @m    Insert Email Address.
::@m::liu0hy@gmail.com

; $date Insert current date.
::$date::
date = %A_YYYY%-%A_MM%-%A_DD%
clipboard = %date%
Send ^v
return

; $time Insert current time.
::$time::
time = %A_HOUR%:%A_MIN%:%A_SEC%
clipboard = %time%
Send ^v
return

; Set window's transparent.
:::alpha::
InputBox, alpha, Transparent, 请输入要设置的透明度（0~255）：, , 150, 170, , , , 60, 255
    res = %ErrorLevel%
If (res<>1)
{
    If (res=0)
    {
        If (alpha > 255)
            alpha = 255
            If (alpha < 0)
            alpha = 0
    }
    If (res=2)
        alpha = 255
        WinSet, Transparent, %alpha%, A 
}
return

:*::border::
    WinGet, st, Style, A
If (st & 0x800000)
WinSet, Style, -0x800000, A
Else
WinSet, Style, +0x800000, A
return

:*::aot::
WinGetActiveTitle, title
WinSet, AlwaysOnTop, Toggle, %title%
return

:*::color::
MouseGetPos, MouseX, MouseY
PixelGetColor, cpp, %MouseX%, %MouseY%, Alt
Transform, blue, BitAnd, %cpp%, 0xff0000
Transform, blue, BitShiftRight, %blue%, 16
Transform, green, BitAnd, %cpp%, 0x00ff00
Transform, green, BitShiftRight, %green%, 8
Transform, red, BitAnd, %cpp%, 0x0000ff
PixelGetColor, html, %MouseX%, %MouseY%, Alt RGB
StringRight, html, html, 6
html=#%html%
StringRight, delphi, cpp, 6
delphi=$00%delphi%
MsgBox, , PixelColor, RGB(%red%, %green%, %blue%)`nC++:%cpp%`nHTML:%html%`nDelphi:%delphi%
return

:*::pos::
CoordMode, Mouse, Screen
MouseGetPos, screenX, screenY
CoordMode, Mouse, Window
MouseGetPos, windowX, windowY
CoordMode, Mouse, Client
MouseGetPos, clientX, clientY
MsgBox, , MousePos, Screen:%screenX%,%screenY%`nWindow:%windowX%,%windowY%`nClient:%clientX%,%clientY%
return

!#UP::
MouseMove, 0, -1, 0, R
return
!#DOWN::
MouseMove, 0, 1, 0, R
return
!#LEFT::
MouseMove, -1, 0, 0, R
return
!#RIGHT::
MouseMove, 1, 0, 0, R
return

^!c::
If WinExist("ahk_class Cygwin")
{
    If WinActive("ahk_class Cygwin")
        WinMinimize
    else
        WinActivate
}
else
{
    Run d:\cygwin\Cygwin.bat
}
