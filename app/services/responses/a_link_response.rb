# frozen_string_literal: true

module Responses
  class ALinkResponse < Response
    def initialize(link, *args)
      super(*args)
      @current_link = link
    end

    protected

    attr_reader :current_link
  end
end
