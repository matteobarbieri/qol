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



main :: IO ()
main = xmonad 
    . ewmhFullscreen 
    . ewmh
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig

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
    , ("M-e"  , spawn "thunar"                   )
    , ("M-S-b"  , spawn "google-chrome"                   ) -- to change
    , ("<XF86MonBrightnessUp>", spawn "lux -a 10%")
    , ("<XF86MonBrightnessDown>", spawn "lux -s 10%")
    ]

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "trayer --edge top --align right --SetDockType true \
            \--SetPartialStrut true --expand true --width 10 \
            \--transparent true --tint 0x5f5f5f --height 48 &"
  --spawnOnce "feh --bg-fill --no-fehbg ~/.wallpapers/haskell-red-noise.png"


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
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

-- Notes
-- lux is required for handling brightness
-- https://lambdablob.com/posts/xmonad-screen-brightness-control-lux/
--
-- List of keyboard strokes:
-- https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Util-EZConfig.html
