# frozen_string_literal: true

Rails.application.routes.draw do
  telegram_webhook TelegramController
end
