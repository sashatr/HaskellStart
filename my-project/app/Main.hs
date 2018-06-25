module Main where

-- import Lib

-- main :: IO ()
-- main = someFunc

-- main = putStrLn "hello, world"

main = do
    putStrLn "Hello, what's your name?"
    name <- getLine
    putStrLn ("Hey " ++ name ++ ", you rock!")
