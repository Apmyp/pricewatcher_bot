# frozen_string_literal: true

class ParseLinkJob < ApplicationJob
  queue_as :default

  def perform(link)
    Raven.extra_context(link_id: link.id, link: link.link)
    link_item, = Links::PerformLink.call(link)

    UpdatedLinkJob.perform_later(link) if link_item.present?
  end
end
