# frozen_string_literal: true

Sidekiq.configure_server do |config|
  # if no url provide it defaults to localhost
  config.redis = { url: ENV['REDISTOGO_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'] }
end
