# frozen_string_literal: true

module Responses
  class LinksResponse < Response
    def type
      :message
    end

    protected

    def links
      @links ||= user.active_links.includes(:active_link_item)
    end

    def text
      I18n.t('telegram.links', count: user.active_links.count)
    end

    def inline_keyboard
      [
        *link_buttons(links),
        [button(text: I18n.t('telegram.add_link'), action: 'create_link')]
      ]
    end

    def link_buttons(links)
      links.map do |link|
        [button(text: link.display_name, action: "link:#{link.id}")]
      end
    end
  end
end
