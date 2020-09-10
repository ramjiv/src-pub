# XMonad like a boss. Or how I learned to love my old computers.

## TL;DR

XMonad is a tiling window manager that's both incredibly stable, uses the minimum amount of system resources and is driven by keyboard allowing you to actually get shit done in a highly productive manner. This means that old computers never become useless, they just become xmonad hosts. 

It is, however, in its default setting both unattractive and intimidating and requires me to remember continually how I set it up in the first place.

Apologies for anyone who wants something more in the way of an explanation, I'm far from a Haskell or X11 guru, but this is my simple Xmonad setup.


In short:
* Two xmobars, one at the top with log outputs and one at the bottom with a state of the world. 
* The Windows/Mac Key is the 'Mod4' key - it's the primary one I use
* Win-Shift-Z will lock the screen with xscreensaver. Good when you need to hide the face you're awesome.
* Win-x will spawn a terminal using sakura (if you can't use sakura, use an xterm, rxvt or gnome-terminal string in the 'myTerminal' variable below
* Printscreen will start 'scrot' a screen capture utility. I never use this, so it's not a 'prerequisite'.
* Beyond that the usual Xmonad shortcut keys will do their things

**Warning**: Once you go xmonad - you spend your whole life going 'weh? what was that combo to push the window back into the tiling format again?'. See the keybindings at the end of this readme

## Breakdown of what's happening
I'm sure I don't need all of these, probably opening these in a haskell aware IDE will make half of these imports not be required.

```haskell
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
```

Kickoff the main flow and immediately spawn the xmobar process

```haskell
main = do   
    xmproc <- spawnPipe "xmobar -f \"xft:'Fira Code'-12\""
    spawn $ xmobar_lower
```
There are *two* xmobar bars, one a the top and one at the bottom. 

- [x] I'm reasonably sure there's a bug here - in that the xmproc *should* be using the ```xmobar_upper``` variable but isn't correctly. *TODO*

```haskell
    xmonad $ docks def
        { layoutHook = avoidStruts  $  layoutHook def
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
```
The above section takes the output from logfiles and puts it into the xmobar output. Kinda useful.

Then we get onto the shortcut keys
```haskell
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod4Mask, xK_x  ), spawn $ myTerminal )
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
```
```haskell
myTerminal = "sakura"
screenSaver = "xscreensaver -nosplash"
xmobar_upper = "xmobar ~/.xmonad/xmobar-upper.config"
xmobar_lower = "xmobar ~/.xmonad/xmobar.config"
```

## Pre-requisites

You will need the following to be installed:

* [xmonad](https://xmonad.org/documentation.html) - use the version in apt
* [xmobar](https://xmobar.org/) - use the version in apt
* [sakura](http://troubleshooters.com/linux/sakura.htm) - use the apt version but just in case.
* [Font: Fira Code - Use the nerdfont version](https://github.com/ryanoasis/nerd-fonts)
* xscreensaver - use the version in apt
* scrot - I'm sure it's in apt   

For the lazy (i.e. me):
```bash
# apt-get install xmonad xmobar sakura xscreensaver scrot
```


## Remembering Keybindings is Hard.

I'm genuinely not sure how many of these actually work well, so I'll go through and do an edit at some point, but until then this excellent image was found on the [haskell wiki](https://wiki.haskell.org/wikiupload/b/b8/Xmbindings.png).

![Local copy in case of the apocalypse](Xmbindings.png)


