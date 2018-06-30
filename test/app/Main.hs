{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.PostgreSQL.Simple
import Control.Monad
import Control.Applicative

main = do
  conn <- connect defaultConnectInfo {
      connectDatabase = "haskell_test"
    , connectUser = "sasha_tr"
    , connectPassword = "23212"

  }

  putStrLn "2 + 2"
  mapM_ print =<< ( query_ conn "select 2 + 2" :: IO [Only Int] )
