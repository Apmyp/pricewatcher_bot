# frozen_string_literal: true

module Responses
  class StatsResponse < Response
    def type
      :message
    end

    def to_h
      {
        text: text
      }
    end

    protected

    def text
      "Пользователей: #{TelegramUser.count}"\
      " (активных: #{TelegramUser.active.count})\n"\
      "Ссылок: #{Link.count}"\
      " (активных: #{Link.active.count})\n"\
      "Ошибок: #{Request.error.count}\n"\
      "Обновлений: #{LinkItem.count}\n"
    end
  end
end
