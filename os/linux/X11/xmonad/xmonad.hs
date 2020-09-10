import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do   
    xmproc <- spawnPipe "xmobar -f \"xft:'Fira Code'-12\""
    spawn $ xmobar_lower
    xmonad $ docks def
        { layoutHook = avoidStruts  $  layoutHook def
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod4Mask, xK_x  ), spawn $ myTerminal )
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]

myTerminal = "sakura"
screenSaver = "xscreensaver -nosplash"
xmobar_upper = "xmobar ~/.xmonad/xmobar-upper.config"
xmobar_lower = "xmobar ~/.xmonad/xmobar.config"
