# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
# require "active_storage/engine"
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SalesBot
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.active_job.queue_adapter = :sidekiq

    Raven.configure do |config|
      config.dsn = Rails.application.credentials.sentry
      config.environments = %w[development production]
      config.async = ->(event) { SentryJob.perform_later(event) }
      config.silence_ready = true
    end

    config.skylight.probes += %w[redis active_job]

    config.after_initialize do
      Parsers::ParserChooser.parsers += [
        Parsers::PumaMoldovaParser,
        Parsers::OriginParser,
        Parsers::MyskinParser,
        Parsers::MoonglowParser,
        Parsers::InglotParser,
        Parsers::ElefantParser,
        Parsers::SephoraParser,
        Parsers::CosmeticshopParser,
        Parsers::MakeupParser,
        Parsers::OvicoParser,
        Parsers::VizajenicaParser,
        Parsers::CultbeautyParser,
        Parsers::PegasParser,
        Parsers::AlcomarketParser,
        Parsers::SonycenterParser,
        Parsers::DarwinParser
      ]
    end
  end
end
