import XMonad

import XMonad.Util.EZConfig
-- import XMonad.Util.Ungrab
-- import XMonad.Operations.unGrab -- does not seem to work just yet
import XMonad.Operations -- does not seem to work just yet

import XMonad.Hooks.EwmhDesktops

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.SpawnOnce (spawnOnce)


import Graphics.X11.ExtraTypes.XF86


main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ xmobarProp $ myConfig

myConfig = def
    { modMask    = mod4Mask  -- Rebind Mod to the Super key
    , terminal = "xfce4-terminal"
    --, layoutHook = myLayout  -- Use custom layouts
    , startupHook = myStartupHook
    }
    `additionalKeysP`
    myKeys

myKeys =
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-C-s", unGrab *> spawn "scrot -s"        )
    , ("M-f"  , spawn "firefox"                   )
    , ("M-S-b"  , spawn "google-chrome"                   ) -- to change
    , ("<XF86MonBrightnessUp>", spawn "lux -a 10%")
    , ("<XF86MonBrightnessDown>", spawn "lux -s 10%")
    ]

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "trayer --edge top --align right --SetDockType true \
            \--SetPartialStrut true --expand true --width 10 \
            \--transparent true --tint 0x5f5f5f --height 18 &"
  --spawnOnce "feh --bg-fill --no-fehbg ~/.wallpapers/haskell-red-noise.png"

-- Notes
-- lux is required for handling brightness
-- https://lambdablob.com/posts/xmonad-screen-brightness-control-lux/
--
-- List of keyboard strokes:
-- https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Util-EZConfig.html
