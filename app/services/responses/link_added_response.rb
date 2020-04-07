# frozen_string_literal: true

module Responses
  class LinkAddedResponse < Response
    def initialize(link, *args)
      super(*args)
      @current_link = link
    end

    def type
      :message
    end

    protected

    attr_reader :current_link

    def text
      I18n.t('telegram.link_added', link_name: current_link.display_name)
    end

    def inline_keyboard
      [
          [link(text: I18n.t('telegram.show_link'), url: current_link.link)],
          [button(text: I18n.t('telegram.add_link'), action: 'create_link')],
          [button(text: I18n.t('telegram.link_added_back'), action: 'links')]
      ]
    end
  end
end
