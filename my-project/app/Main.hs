{-# LANGUAGE MultiWayIf #-}

module Main where

import Lib
import Data.List
import Data.Char
-- import Data.Text.IO as TIO


data Transport = TCP | UDP | SCTP

data WorkMode = FiveDays | SixDays

data Day = Sunday
         | Monday
         | Tuesday
         | Wednesday
         | Thursday
         | Friday
         | Saturday


workingDays :: WorkMode -> [Day]
workingDays FiveDays = [ Monday
                      , Tuesday
                      , Wednesday
                      , Thursday
                      , Friday
                      ]

workingDays SixDays = [ Monday
                     , Tuesday
                     , Wednesday
                     , Thursday
                     , Friday
                     , Saturday
                     ]

data IPAddress = IPv4 String
              | IPv4Localhost
              | IPv6 String
              | IPv6Localhost

newtype IPAddress' = IP String


checkProtocol :: Transport -> String
checkProtocol transport = case transport of
  TCP  -> "That's TCP protocol."
  UDP  -> "That's UDP protocol."
  SCTP -> "That's SCTP protocol."


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


chessMove :: String
         -> (String, String)
         -> (String, (String, String))
chessMove color (from, to) = (color, (from, to))


type UUID     = String
type FullName = String
type Email    = String
type Age      = Int
type Patient = (UUID, FullName, Email, Age)

patientEmail :: Patient -> Email
patientEmail (_, _, email, _) = email


type Func = String -> Bool

validComEmail :: String -> Bool
validComEmail email =
    containsAtSign email && endsWithCom email
  where
    containsAtSign = (\e -> "@" `isInfixOf` e) :: Func
    endsWithCom = (\e -> ".com" `isSuffixOf` e) :: Func


toUpperCase :: String -> String
toUpperCase str = map toUpper str


ten :: [Double] -> [Double]
ten = map (\n -> n * 10)


bad :: [Int] -> Int -> Int
bad []         c = c
bad (_:others) c = bad others $! c + 1


main :: IO ()
main = putStrLn . checkProtocol $ TCP

-- let ip = IPAddress "127.0.0.1"


-- main = print $ bad [1..50000000] 0

-- main = print $ evens
  -- where evens = [2, 4 ..]  -- hmm, wow

-- main = putStrLn "test"
-- main = print . ten $ [1.2, 1,4, 1.6]

-- main = putStrLn . toUpperCase $ ['h','a','s','k','e','l','l','.']
-- main = putStrLn (if validComEmail my
--                    then "It's ok!"
--                    else "Non-com email!")
--   where
--     my = "haskeller@gmail.com"

-- main = putStrLn $ checkLocalhost "173.194.22.100"
-- main = putStrLn (analyzeGold 999)
-- calculateTime 100
-- main = putStrLn (head ["A", "B", "C"])  -- tail
-- main = print [0..10]

-- main = print (color ++ ": " ++ from ++ "-" ++ to)
  -- where
    -- (color, (from, to)) = chessMove "white" ("e2", "e4")

-- main =
--   putStrLn (patientEmail ( "63ab89d"
--                          , "John Smith"
--                          , "johnsm@gmail.com"
--                          , 59
--                          ))

-- main = putStrLn ((head functions) "Hi")
--   where
--     functions = [ \x -> x ++ " val1"
--                 , \x -> x ++ " val2"
--                 ]
