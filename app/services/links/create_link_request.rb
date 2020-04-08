# frozen_string_literal: true

module Links
  class CreateLinkRequest
    def self.call(*args)
      new(*args).call
    end

    def initialize(link:, status:, html:)
      @link = link
      @status = status
      @html = html
    end

    def call
      link.requests.create!(
        status: status,
        html: html
      )
    end

    private

    attr_reader :link, :html, :status
  end
end
