module Main where

-- import Lib

checkLocalhost :: String -> String
checkLocalhost ip =
  if ip == "127.0.0.1" || ip == "0.0.0.0"
    then "It's a localhost!"
    else "No, it's not a localhost."

main :: IO ()
main = putStrLn (checkLocalhost "173.194.22.100")
