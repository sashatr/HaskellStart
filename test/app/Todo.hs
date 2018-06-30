{-# LANGUAGE OverloadedStrings #-}
module Todo where

import Data.Text
import Data.Int                                (Int64)
import Data.ByteString                         (ByteString)
import Control.Applicative
import Control.Monad.IO.Class                  (liftIO)
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.ToField
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToRow


data TodoItem = TodoItem { id_user :: Int
                         , name :: Text
                         , mes :: Text
                         } deriving Show

instance FromRow TodoItem where
  fromRow = TodoItem <$> field <*> field <*> field

instance ToRow TodoItem where
  toRow t = [toField (id_user t), toField (name t), toField (mes t)]

allTodoItems :: Connection -> IO [TodoItem]
allTodoItems c = query_ c "SELECT id, name, mes FROM users2"

getTodoItem :: Connection -> Int -> IO [TodoItem]
getTodoItem c id = query c "SELECT id, name, mes FROM users2 WHERE id = ?" $ Only id

addTodoItem :: Connection -> TodoItem -> IO Int64
addTodoItem c i = execute c "INSERT INTO users2 (id, name, mes) VALUES (?, ?, ?)" i

changeTodoItem :: Connection -> TodoItem -> IO Int64
changeTodoItem c i = execute c "UPDATE users2 SET name = ?, mes = ? WHERE id = ?"
                     (name i, mes i, id_user i)

removeTodoItem :: Connection -> TodoItem -> IO Int64
removeTodoItem c i = execute c "DELETE FROM users2 WHERE id = ?" $ Only $ id_user i

main :: IO ()
main = do
  conn <- connect defaultConnectInfo {
      connectDatabase = "haskell_test"
    , connectUser = "sasha_tr"
    , connectPassword = "23212"
  }
  putStrLn "Connected."
  mapM_ (putStrLn . show) =<< allTodoItems conn
  -- mapM_ (putStrLn . show) =<< getTodoItem conn 0
  -- putStrLn . show =<< addTodoItem conn TodoItem {id_user=3, name="user4", mes="mes4"}
  -- putStrLn . show =<< changeTodoItem conn TodoItem {id_user=3, name="user4.1", mes="mes4.1"}
  -- putStrLn . show =<< removeTodoItem conn TodoItem {id_user=3, name="user4.1", mes="mes4.1"}
  putStrLn "The End."
