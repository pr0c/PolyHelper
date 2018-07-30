class BotFunc

  #actions
  NONE = nil
  ATEST = -1
  START = 0

  #commands
  def self.cmdStart(bot, message) # /start
    case @action
    when START
      if @fname.nil? && !@lname.nil?
        @fname = message.text
        bot.api.sendMessage(chat_id: message.chat.id, text: "Введіть ваше прізвище")
      elsif @lname.nil?
        @lname = message.text
        @@user = User.new(@fname, @lname)
        bot.api.sendMessage(chat_id: message.chat.id, text: "Вітаємо, #{@fname} #{@lname}")
        if @@user.thisExists?()
          #user exists
        else

        end
      else
        bot.api.sendMessage(chat_id: message.chat.id, text: "Введіть ваше ім'я")
      end
    end
  end

  def self.cmdTest(bot, message)
    bot.api.sendMessage(chat_id: message.chat.id, text: "Hello my dear friend")
  end

  #######
  def self.action=(act)
    @action = act
  end

  def self.action()
    @action
  end
end
