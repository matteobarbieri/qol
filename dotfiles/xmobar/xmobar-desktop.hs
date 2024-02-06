import Xmobar

my_bgcolor, my_fgcolor :: String
my_bgcolor =  "#5f5f5f"
my_fgcolor =  "#f8f8f2"

my_coloryellow :: String
my_coloryellow ="#FFC135" 

magenta = "#D81B60"
blue = "#42A5F5"
light_blue = "#00ACC1"
red = "#FF443E"
olive_green = "#C3D82C"

--blue, lowWhite, magenta, red, white, yellow :: String
--magenta  = "#"
--blue     = "#"
--white    = "#"
--yellow   = "#FFC135"
--red      = "#"
--lowWhite = "#"

config :: Config
config =
    defaultConfig
      -- { 
      { 
        --font = "xft:Mononoki Nerd Font:size=28:style=Bold",
        font = "mononoki Nerd Font 14",
        additionalFonts = ["xft:iosevka-14", "mononoki Nerd Font 14"],
        --additionalFonts = ["xft:iosevka-14", "xft:Mononoki Nerd Font:size=14"],
        overrideRedirect = False,
        bgColor  = my_bgcolor,
        fgColor  = my_fgcolor,
        position = TopSize L 90 26,
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
                        ("us", "\xf097b US")
                        , ("se", "<fn=2>\xf097b </fn>SE")
                        , ("it", "<fn=2>\xf097b </fn>IT")
                    ]
                    -- https://codeberg.org/xmobar/xmobar/src/branch/master/doc/plugins.org#user-content-volume
                    , Run $ Alsa "default" "Master"
                        [ 
                          --"--template", "<status>"
                          "--template", "<volumestatus>"
                        , "--suffix"  , "True"
                        , "--"
                        , "-l", "<fn=2>\xf057f </fn>"
                        , "-m", "<fn=2>\xf0580 </fn>"
                        , "-h", "<fn=2>\xf057e </fn>"
                        , "--off", "<fn=2>\xf075f </fn>"
                        , "--on", ""
                        , "--onc", "white"
                        , "--offc", "white"
                        ]
                    , Run $ Memory ["--template", "Mem: <usedratio>%"] 10
                    --, Run Swap [] 10
                    --, Run $ Date "<fc=#8be9fd><fn=2>\xf073 </fn> %a %Y-%m-%d <fn=2>\xf017 </fn>%H:%M</fc>" "date" 10
                    , Run $ Date "<fc=#FFC135><fn=2>\xf073 </fn> %a %Y-%m-%d <fn=2>\xf017 </fn>%H:%M</fc>" "date" 10
                    , Run XMonadLog
                    ],
       sepChar  = "%",
       alpha = 200,
       template = "%XMonadLog% }{ %alsa:default:Master% | %kbd% |  %date% ",
        alignSep = "}{"
      }

main :: IO ()
main = xmobar config  -- or: configFromArgs config >>= xmobar
