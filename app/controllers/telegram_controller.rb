class TelegramController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :set_current_user

  def start!(*)
    msg = "*Привет, #{current_user.first_name}!*\nКак тебе наш бот?"
    respond_with :message, text: msg, parse_mode: :Markdown
  end

  def stop!(*)
    msg = "Больше мы тебя не побеспокоим"
    respond_with :message, text: msg, parse_mode: :Markdown
  end

  def mylinks!(*)
    respond_with :message, text: 'Выбери ссылку', reply_markup: {
        inline_keyboard: [
            Telegram::MakeIkForLinks.call(current_user.active_links),
            Telegram::MakeIkForCreateLink.call(current_user),
        ]
    }
  end

  def callback_query(data)
    if data == 'alert'
      edit_message :text, text: 'Выбери ссылку', reply_markup: {
          inline_keyboard: [
              [
                  {text: 'https://example.com111', callback_data: 'alert'},
              ],
          ],
      }
    elsif data[/link:\d+/]
      link_id = data.scan(/link\:(\d+)/).first.first.to_i
      respond_with :message, text: "Ссылка #{link_id}"
    elsif data == 'create_link'
      newlink!(nil)
    end
  end

  def newlink!(raw_link = nil, *)
    if raw_link
      link = Links::CreateLink.call(current_user, raw_link)
      msg = "Добавлена ссылка #{link.host} (\##{link.hash_id})"
      respond_with :message, text: msg, parse_mode: :Markdown
    else
      save_context :newlink!
      msg = "Скинь ссылку на товар. Мы поддерживаем тех-то и вон тех-то"
      respond_with :message, text: msg, parse_mode: :Markdown
    end
  end


  private

  attr_reader :current_user

  def set_current_user
    @current_user ||= FindOrCreateTelegramUser.call(from)
  end
end