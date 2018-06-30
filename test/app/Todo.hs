{-# LANGUAGE OverloadedStrings #-}
module Todo where

import Data.Text
import Data.Int (Int64)
import Data.ByteString (ByteString)
import Control.Applicative
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.ToField
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToRow


data TodoItem = TodoItem { name :: Text
                         , mes :: Text
                         } deriving Show

instance FromRow TodoItem where
  fromRow = TodoItem <$> field <*> field

uri :: ByteString
uri = "postgres://sasha_tr@localhost/haskell_test"

allTodoItems :: Connection -> IO [TodoItem]
allTodoItems c = query_ c "SELECT name, mes FROM users"

main :: IO ()
main = do
  conn <- connect defaultConnectInfo {
      connectDatabase = "haskell_test"
    , connectUser = "sasha_tr"
    , connectPassword = "23212"
  }
  putStrLn "Connected."
  mapM_ (putStrLn . show) =<< allTodoItems conn
  -- mapM_ (putStrLn . show) =<< getTodoItem conn 2
