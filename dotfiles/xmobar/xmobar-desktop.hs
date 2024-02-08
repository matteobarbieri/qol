import Xmobar

my_bgcolor, my_fgcolor :: String
my_bgcolor =  "#4f4f4f"
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
        font = "Mononoki Nerd Font 14",
        additionalFonts = ["CommitMono Nerd Font Propo 14"],
        --additionalFonts = ["xft:iosevka-14", "xft:Mononoki Nerd Font:size=14"],
        overrideRedirect = False,
        bgColor  = my_bgcolor,
        fgColor  = my_fgcolor,
        position = TopSize L 100 26,
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
                        [ "-L", "50"
                        , "-H", "75"
                        , "--high"  , "red"
                        , "--normal", "white"
                        , "--template", "\xf4bc  <total>%"
                        ] 10
                    , Run $ Kbd [
                        ("us", "\xf097b US")
                        , ("se", "\xf097b SE")
                        , ("it", "\xf097b IT")
                    ]
                    -- https://codeberg.org/xmobar/xmobar/src/branch/master/doc/plugins.org#user-content-volume
                    -- , Run $ Alsa "default" "Master"
                    , Run $ Alsa "hw:6" "PCM"
                        [ 
                          --"--template", "<status>"
                          "--template", "<volumestatus>"
                        , "--suffix"  , "True"
                        , "--"
                        , "-l", "\xf057f "
                        , "-m", "\xf0580 "
                        , "-h", "\xf057e "
                        , "--off", "\xf075f "
                        , "--on", ""
                        , "--onc", "white"
                        , "--offc", "white"
                        ]
                    , Run $ Memory ["--template", "Mem: <usedratio>%"] 10
                    --, Run Swap [] 10
                    --, Run $ Date "<fc=#8be9fd><fn=2>\xf073 </fn> %a %Y-%m-%d <fn=2>\xf017 </fn>%H:%M</fc>" "date" 10
                    , Run $ Date "<fc=#FFC135><fn=1>\xf073 </fn> %a %Y-%m-%d <fn=1>\xf017 </fn>%H:%M</fc>" "date" 10
                    , Run XMonadLog
                    ],
       sepChar  = "%",
       alpha = 255,
      --  template = "%XMonadLog% }{ | %alsa:default:Master% | %cpu% | %kbd% |  %date% ",
       template = "%XMonadLog% }{ | %alsa:hw:6:PCM% | %cpu% | %kbd% |  %date% ",
        alignSep = "}{"
      }

main :: IO ()
main = xmobar config  -- or: configFromArgs config >>= xmobar
