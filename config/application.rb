require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VeloxpressApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # Do not swallow errors in after_commit/after_rollback callbacks.

    config.action_dispatch.default_headers.merge!({
                'Access-Control-Allow-Origin' => '*',
                'Access-Control-Request-Method' => '*'
    })

    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      html_tag
    }

    config.action_mailer.delivery_method = :smtp
    # SMTP settings for gmail
    config.action_mailer.smtp_settings = {
        :address              => "smtp.gmail.com",
        :port                 => 587,
        :user_name            => 'ignacio@veloexpress.cl',
        :password             => 'Veloexpress',
        :authentication       => "plain",
        :enable_starttls_auto => true
    }
    config.action_mailer.perform_deliveries = true

    config.assets.precompile += %w( admin/init_map.js )
    config.assets.precompile += %w( admin/init_map_edit.js )
    config.active_record.raise_in_transactional_callbacks = true
    config.active_job.queue_adapter = :delayed_job
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end
