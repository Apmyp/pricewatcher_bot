# frozen_string_literal: true

class ParseLinkJob < ApplicationJob
  queue_as :default

  def perform(link)
    link_item, = Links::PerformLink.call(link)

    UpdatedLinkJob.perform_later(link) if link_item.present?
  end
end
