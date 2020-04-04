class ParseLinkJob < ApplicationJob
  queue_as :default

  def perform(link)
    link_item, diff = Links::PerformLink.call(link)

    if link_item.present?
      UpdatedLinkJob.perform_later(link)
    end
  end
end
