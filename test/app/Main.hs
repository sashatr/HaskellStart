{-# LANGUAGE OverloadedStrings #-}
module Main where

import System.Environment (getArgs)

import qualified Todo

main :: IO ()
main = Todo.main
