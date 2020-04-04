# frozen_string_literal: true

class FindOrCreateTelegramUser
  def self.call(*args)
    new.call(*args)
  end

  def call(from)
    TelegramUser.find_or_create_by(external_id: from['id']) do |user|
      user.first_name = from['first_name']
      user.username = from['username']
      user.language_code = from['language_code']
      user.raw_data = from
      user.subscribed = true
      user.status = :active
    end
  end
end
