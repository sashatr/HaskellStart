{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Applicative
import Control.Monad.IO.Class                  (liftIO)

import Data.Text                               (Text, pack)
import Data.Int                                (Int64)
import Data.ByteString                         (ByteString)
import qualified Data.Text                     as Text

import qualified Telegram.Bot.API              as Telegram
import Telegram.Bot.Simple
import Telegram.Bot.Simple.UpdateParser

import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.ToField
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToRow

data TodoItem = TodoItem { todo_item :: Text
                         } deriving Show
type Model = [Text]

data Action
  = NoOp
  | Start
  | AddItem Text
  | RemoveItem Text
  | Show

instance FromRow TodoItem where
  fromRow = TodoItem <$> field

instance ToRow TodoItem where
  toRow t = [toField (todo_item t)]

conn :: IO Connection
conn = do
  connect defaultConnectInfo {
    connectDatabase = "haskell_test"
  , connectUser = "sasha_tr"
  , connectPassword = "23212"}

startMessage :: Text
startMessage = Text.unlines ( map pack
 [ "Hi there! I am your personal todo bot :)"
 , ""
 , "With me you can keep track of things to do:"
 , "- just type what you need to do an I'll remember it!"
 , "- use /remove <item> to remove an item"
 , "- use /show to show all current things to do"
 , ""
 , "So what's the first thing on your to do list? :)"
 ])

startMessageKeyboard :: Telegram.ReplyKeyboardMarkup
startMessageKeyboard = Telegram.ReplyKeyboardMarkup
  { Telegram.replyKeyboardMarkupKeyboard =
      [ [ Telegram.KeyboardButton (pack "Buy milk") Nothing Nothing,
          Telegram.KeyboardButton (pack "Bake a cake") Nothing Nothing ] ]
  , Telegram.replyKeyboardMarkupResizeKeyboard = Just True
  , Telegram.replyKeyboardMarkupOneTimeKeyboard = Just True
  , Telegram.replyKeyboardMarkupSelective = Just True
  }

bot :: BotApp Model Main.Action
bot = BotApp
  { botInitialModel = []
  , botAction = flip handleUpdate
  , botHandler = handleAction
  , botJobs = []
  }
  where
    handleUpdate :: Model -> Telegram.Update -> Maybe Main.Action
    handleUpdate _model = parseUpdate $
          AddItem    <$> plainText
      <|> Show       <$  command (pack "show")
      <|> RemoveItem <$> command (pack "remove")
      <|> Start      <$  command (pack "start")

    handleAction :: Main.Action -> Model -> Eff Main.Action Model
    handleAction action model = case action of
      NoOp -> pure model
      Start -> model <# do
        reply (toReplyMessage startMessage)
          { replyMessageReplyMarkup = Just (Telegram.SomeReplyKeyboardMarkup startMessageKeyboard) }
        pure NoOp
      Show -> model <# do
        if null model
          then replyText (pack "No text")
          else replyText (Text.unlines model)
        pure NoOp
      AddItem item -> (item : model) <# do
        co <- liftIO conn
        liftIO $ addTodoItem co TodoItem {todo_item=item}
        pure Show
        where
          addTodoItem :: Connection -> TodoItem -> IO Int64
          addTodoItem c i = execute c "INSERT INTO todo (item) VALUES (?)" i

      RemoveItem item -> filter (/= item) model <# do
        co <- liftIO conn
        liftIO $ removeTodoItem co TodoItem {todo_item=item}
        pure Show
        where
          removeTodoItem :: Connection -> TodoItem -> IO Int64
          removeTodoItem c i = execute c "DELETE FROM todo WHERE item = ?" $ Only $ todo_item i

run :: Telegram.Token -> IO ()
run token = do
  env <- Telegram.defaultTelegramClientEnv token
  startBot_ bot env

main :: IO ()
main = do
  putStrLn "Telegram bot is not implemented yet!"
