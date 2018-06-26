module Main where

-- import Lib

checkLocalhost :: String -> String
checkLocalhost ip =
  if ip == "127.0.0.1" || ip == "0.0.0.0"
    then "It's a localhost!"
    else "No, it's not a localhost."

analyzeGold :: Int -> String
analyzeGold standard =
  if standard == 999
    then "Wow! 999 standard!"
    else if standard == 750
           then "Great! 750 standard."
           else if standard == 585
                  then "Not bad! 585 standard."
                  else "I don't know such a standard..."

main :: IO ()
-- main = putStrLn $ checkLocalhost "173.194.22.100"
main = putStrLn (analyzeGold 999)
