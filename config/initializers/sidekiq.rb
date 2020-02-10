Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://172.16.100.11:6408/12' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://172.16.100.11:6408/12' }
end
