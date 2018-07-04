See [source](https://github.com/fizruk/telegram-bot-simple) of author Library for Telegram

## Start

In `stack ghci` run function main and pass the token.

Example:
```
*Main> main
Please, enter Telegram bot's API token:
token
Ok, go
```
## About bot

The bot is based on the author's example but with my repository in PostgreSQL. 
- Each item is added and removed from the table.
- Cleaning the database during new work.

## Example

When the /starts bot, the bot connects to the database and saves all the items in the table.

![example](https://raw.githubusercontent.com/sashatr/HaskellStart/master/Haskell-telegram-bot/images/example_1.png)
```
Table Contents:
      item     | 
---------------- ....
 -> test_item_2
 -> test_item_1
                 
```

After deleting (```/ remove -> test_item_1```), the table looks like this:
```
Table Contents:
      item     | 
---------------- ....
 -> test_item_2
                 
```
