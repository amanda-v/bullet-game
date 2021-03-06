{-# LANGUAGE OverloadedStrings #-}

module Script.End where

import qualified Play.Engine.MySDL.MySDL as MySDL
import qualified SDL.Mixer as Mix

import Data.Maybe (fromJust)
import Script
import Play.Engine
import qualified Credits
import qualified TextBox as TB
import qualified Data.Map as M


end :: Bool -> Scene
end playMusic =
  Credits.make 0 $ Script
    wantedAssets
    (lScript playMusic)
    (end False)


wantedAssets :: [(String, MySDL.ResourceType FilePath)]
wantedAssets =
  TB.wantedAssets
  ++ [ ("music-end", MySDL.Music "end.ogg")
     , ("nyx-avatar", MySDL.Texture "nyx-avatar.png")
     ]


lScript :: Bool -> MySDL.Resources -> Script
lScript playMusic MySDL.Resources{ MySDL.fonts = fs, MySDL.music = ms } =
  [ PlayMusic Mix.Once ("music-end", M.lookup "music-end" ms)
  | playMusic
  ] ++
  [ TextUp 3 (fromJust $ M.lookup "unispace" fs) (Point 280 1000) "ART BY: @trixelbit"
  , TextUp 2 (fromJust $ M.lookup "unispace" fs) (Point 300 1000) "GAME BY: @_gilmi"
  , TextUp 2 (fromJust $ M.lookup "unispace" fs) (Point 270 1000) "THANKS FOR PLAYING!"
  , Wait noAction 60
  , StopMusic
  , Wait act{ command = Done } 120
  ]
