require 'raven'

Raven.configure do |config|
  # URL where the events are sent
  config.dsn = ENV['SENTRY_DSN_BACKEND']
  # Filter fields filtered by Rails
  config.ssl_verification = true
  config.environments = %w[ production ]
  # Set version, see application.html.haml
  config.release = ENV['APP_RELEASE']
end

# Set Heroku App URL to event context
Raven.extra_context heroku_app: ENV['APP_URL'] || ENV['APP_NAME']