# frozen_string_literal: true

module Links
  class DisableLink
    def self.call(*args)
      new(*args).call
    end

    def initialize(link)
      @link = link
    end

    def call
      link.update!(status: :disabled)
      link
    end

    private

    attr_reader :link
  end
end
