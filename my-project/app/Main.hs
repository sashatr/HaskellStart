{-# LANGUAGE MultiWayIf #-}

module Main where

import Lib
import Data.List


checkLocalhost :: String -> String
checkLocalhost ip =
  if ip == "127.0.0.1" || ip == "0.0.0.0"
    then "It's a localhost!"
    else "No, it's not a localhost."


analyzeGold :: Int -> String
analyzeGold 999 = "Wow! 999 standard!"
analyzeGold 750 = "Great! 750 standard."
analyzeGold 585 = "Not bad! 585 standard."
analyzeGold _   = "I don't know such a standard..."


calculateTime :: Int -> Int
calculateTime timeInS =
  let threshold  = 40
      correction = 120
      delta      = 8
  in
  if | timeInS <  threshold -> timeInS + correction
     | timeInS >= threshold -> timeInS + delta + correction


main :: IO ()
-- main = putStrLn $ checkLocalhost "173.194.22.100"
-- main = putStrLn (analyzeGold 999)
-- calculateTime 100
-- main = putStrLn (head ["A", "B", "C"])  -- tail
main = print [0..10]
