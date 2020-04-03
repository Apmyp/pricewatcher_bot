class TelegramController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :set_current_user

  def start!(*)
    msg = "*Привет, #{current_user.first_name}!*\nКак тебе наш бот?"
    respond_with :message, text: msg
  end

  def stop!(*)
    msg = "Больше мы тебя не побеспокоим"
    respond_with :message, text: msg
  end

  def mylinks!(*)
    respond_with :message, links
  end

  def newlink!(raw_link = nil, *)
    if raw_link
      link = Links::CreateLink.call(current_user, raw_link)
      respond_with :message, link_added(link)
    else
      save_context :newlink!
      respond_with :message, new_link
    end
  end

  def callback_query(data)
    if data == 'links'
      edit_message :text, links
    elsif data[/^link:\d+/]
      link_id = data.scan(/^link\:(\d+)/).first.first.to_i
      edit_message :text, link(Link.find(link_id))
    elsif data[/^destroy_link:\d+/]
      link_id = data.scan(/^destroy_link\:(\d+)/).first.first.to_i
      Link.find(link_id).destroy
      answer_callback_query("Ссылка удалена")
      edit_message :text, links
    elsif data == 'create_link'
      newlink!
    end
  end

  private

  attr_reader :current_user

  def set_current_user
    @current_user ||= FindOrCreateTelegramUser.call(from)
  end

  def links
    {
        text: 'Выбери ссылку', reply_markup: {
        inline_keyboard: Telegram::MakeIkForLinks.call(current_user.active_links)
                             .concat([[Telegram::MakeIkForCreateLink.call]])}
    }
  end

  def link(link)
    {
        text: "Ссылка #{link.id}", reply_markup: {
        inline_keyboard: [
            [
                Telegram::MakeIkForBackLink.call(action: 'links'),
                Telegram::MakeIkForDeleteLink.call(link)
            ]
        ]}
    }
  end

  def new_link
    msg = "Скинь ссылку на товар. Мы поддерживаем тех-то и вон тех-то"
    {text: msg}
  end

  def link_added(link)
    msg = "Добавлена ссылка #{link.display_name}"
    {text: msg, reply_markup: {
        inline_keyboard: [
            [
                Telegram::MakeIkForDeleteLink.call(link),
                Telegram::MakeIkForCreateLink.call,
            ]
        ]}}
  end
end