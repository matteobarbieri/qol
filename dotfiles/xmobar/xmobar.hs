import Xmobar

config :: Config
config =
    defaultConfig
      -- { 
      { 
        font = "xft:Mononoki Nerd Font:size=14:style=Bold",
        additionalFonts = ["xft:iosevka-14", "xft:Mononoki Nerd Font:size=14"],
        overrideRedirect = False,
        bgColor  = "#5f5f5f",
        fgColor  = "#f8f8f2",
        position = TopW L 90,
        allDesktops = True,
        commands = [ 
                    Run $ Weather "EGPF"
                        [ "--template", "<weather> <tempC>°C"
                        , "-L", "0"
                        , "-H", "25"
                        , "--low"   , "lightblue"
                        , "--normal", "#f8f8f2"
                        , "--high"  , "red"
                        ] 36000
                    , Run $ Cpu
                        [ "-L", "3"
                        , "-H", "50"
                        , "--high"  , "red"
                        , "--normal", "green"
                        ] 10
                    , Run $ Kbd [
                        ("us", "<fn=2>\xf097b </fn>US")
                        , ("se", "<fn=2>\xf097b </fn>SE")
                        , ("it", "<fn=2>\xf097b </fn>IT")
                    ]
                    , Run $ Battery [
                        "-t", "<acstatus> <left>%",
                        "--",
                        --"-c", "charge_full",
                        "--lows"   , "<fn=0>\xf007a</fn>",
                        "--mediums", "<fn=0>\xf007e</fn>",
                        "--highs"  , "<fn=0>\xf0079</fn>",
                        "-O", "<fn=0>\xf06a5</fn>",
                        "-i", "<fn=0>\xf06a5</fn>",
                        "-o", "",
                        "-h", "green",
                        "-l", "red"
                        ] 10
                    --, Run $ Volume "default" "Master"
                     --[] 10
                    -- https://codeberg.org/xmobar/xmobar/src/branch/master/doc/plugins.org#user-content-volume
                    , Run $ Alsa "default" "Master"
                        [ "--template", "<fn=2>\xf057e </fn><volumestatus>"
                        , "--suffix"  , "True"
                        , "--"
                        , "--on", ""
                        ]
                    , Run $ Memory ["--template", "Mem: <usedratio>%"] 10
                    --, Run Swap [] 10
                    , Run $ Date "<fc=#8be9fd><fn=2>\xf073 </fn> %a %Y-%m-%d <fn=2>\xf017 </fn>%H:%M</fc>" "date" 10
                    , Run XMonadLog
                    ],
       sepChar  = "%",
       alpha = 200,
       template = "%XMonadLog% }{ %alsa:default:Master% | %battery% | %kbd% |  %date% ",
        alignSep = "}{"
      }

main :: IO ()
main = xmobar config  -- or: configFromArgs config >>= xmobar
