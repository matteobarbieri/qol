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

import XMonad.Util.Loggers

import XMonad.Actions.GridSelect

mycolor_green :: String
mycolor_green = "#C3D82C"

-- Configuration for grid select
gsconfig1 = def 
    { gs_cellheight = 90
    , gs_cellwidth = 400 
    , gs_font = "xft:Mononoki Nerd Font:size=10"
    }

myConfig = def
    { modMask    = mod4Mask  -- Rebind Mod to the Super key
    , terminal = "xfce4-terminal"
    --, layoutHook = myLayout  -- Use custom layouts
    , startupHook = myStartupHook
    --, focusedBorderColor = "#C3D82C"
    , focusedBorderColor = mycolor_green
    , borderWidth = 2
    }
    `additionalKeysP`
    myKeys

myKeys =
    [ ("M-S-z", spawn "slock")
    , ("M-C-s", unGrab *> spawn "scrot -s"        )
    , ("M-p", spawn "dmenu_run -fn 'FiraCode-14'")
    , ("M-e"  , spawn "thunar"                   )
    , ("M-S-b"  , spawn "google-chrome"                   ) -- to change
    , ("M-g", goToSelected gsconfig1)
    , ("<XF86MonBrightnessUp>", spawn "lux -a 10%")
    , ("<XF86MonBrightnessDown>", spawn "lux -s 10%")
    , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 2%-")
    , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 2%+")
    , ("<XF86AudioMute>", spawn "amixer -D pulse set Master toggle")

    ]

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "picom &"
  spawnOnce "dropbox start"
  spawnOnce "setxkbmap -layout us,it,se -option 'grp:alt_shift_toggle'"
  spawnOnce "stalonetray &"
  -- Code for trayer
  --spawnOnce "trayer --edge top --align right --SetDockType true \
  --          \--SetPartialStrut true --expand true --width 10 \
  --          \--transparent true --tint 0x5f5f5f --alpha 55 \
  --          \--distancefrom right --distance 560 \
  --          \--monitor primary &"
  spawnOnce "feh --bg-fill --no-fehbg ~/.wallpapers/rubix-cube-creativity-2560x1440-v0-7lnsnj1104391.jpg"


myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "???" else w) . shorten 13

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

main :: IO ()
main = do
    xmonad 
    . ewmhFullscreen 
    . ewmh
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig


-- Notes
-- lux is required for handling brightness
-- https://lambdablob.com/posts/xmonad-screen-brightness-control-lux/
--
-- List of keyboard strokes:
-- https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Util-EZConfig.html
