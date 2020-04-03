class TelegramController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :set_current_user

  def start!(*)
    current_user.update(status: :active)
    msg = "*Привет, #{current_user.first_name}!*\nКак тебе наш бот?"
    respond_with :message, text: msg
  end

  def help!(*)
    msg = "Вот чем я могу тебе помочь:"
    respond_with :message, text: msg
  end

  def stop!(*)
    current_user.update(status: :disabled)
    msg = "Больше мы тебя не побеспокоим"
    respond_with :message, text: msg
  end

  def mylinks!(*)
    respond_with :message, links
  end

  def newlink!(raw_link = nil, *)
    if raw_link
      begin
        link = Links::CreateLink.call(current_user, raw_link)
      rescue Links::PathNotFoundException, ActiveRecord::RecordInvalid
        save_context :newlink!
        respond_with :message, link_not_added
        logger.info "I cant create the link. Can you investigate why? Link: #{raw_link}"
      else
        respond_with :message, link_added(link)
      end
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
    msg = if current_user.active_links.any?
            'Выбери ссылку'
          else
            'Блин, а ссылок-то нет. Хочешь добавить первую?'
          end

    {
        text: msg, reply_markup: {
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
    msg = "Добавлена ссылка #{link.display_name}\n\nКогда будет инфа — я сообщу"
    {text: msg, reply_markup: {
        inline_keyboard: [
            [Telegram::MakeIkForDeleteLink.call(link)],
            [Telegram::MakeIkForCreateLink.call],
        ]}}
  end

  def link_not_added
    {text: 'Че-то не так с ссылкой. Проверь чтобы все было ок и отправь ссылку еще раз'}
  end
end