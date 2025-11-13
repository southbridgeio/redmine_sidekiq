require 'sidekiq'

module RedmineSidekiq
  class Configure
    file = File.join(::Rails.root, 'plugins/redmine_sidekiq/config/sidekiq.yml')
    if File.exist?(file)
      config = YAML.load_file(file)[::Rails.env]
      redis_conf = config['redis'].symbolize_keys
    end

    Sidekiq.configure_server do |config|
      config.redis = redis_conf if redis_conf
    end

    Sidekiq.configure_client do |config|
      config.redis = redis_conf if redis_conf
    end

  end
end
