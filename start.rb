require 'telegram/bot'
require 'sqlite3'
require 'rainbow/refinement'
require_relative 'botfunc'
require_relative 'dbutils'
require_relative 'user'
using Rainbow

token = File.open("config.cfg") { |file| file.read  }

$db = DBUtils.new()

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      BotFunc.action = BotFunc::START
      BotFunc.cmdStart(bot, message)
    when '/hello'
      BotFunc.action = BotFunc::ATEST
      BotFunc.cmdTest(bot, message)
    else
      case BotFunc.action
      when BotFunc::START
        BotFunc.cmdStart(bot, message)
      end
    end
  end
end
