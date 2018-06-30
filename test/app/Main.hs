{-# LANGUAGE OverloadedStrings #-}
module Main where

import System.Environment (getArgs)

import qualified Todo

main :: IO ()
main = Todo.main


-- parse ["todo"] = Todo.main
-- parse _ = putStrLn "usage: result/bin/postgresql-simple-examples [c|w|b|s|t|clients|words|basics|santa|todo]"
