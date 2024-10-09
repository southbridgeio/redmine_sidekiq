require 'sidekiq/web'
require './plugins/redmine_sidekiq/lib/redmine_sidekiq/web_constraint'

begin
  require 'sidekiq/cron/web'
rescue LoadError
  # Nothing
end

RedmineApp::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq', constraints: RedmineSidekiq::WebConstraint.new

  match '/sidekiq/sandbox', to: 'sidekiq_sandbox#index', via: :get
  match '/sidekiq/sandbox/perform_async', to: 'sidekiq_sandbox#perform_async', via: :post
  match '/sidekiq/sandbox/perform_in', to: 'sidekiq_sandbox#perform_in', via: :post
  match '/sidekiq/sandbox/perform_at', to: 'sidekiq_sandbox#perform_at', via: :post
end
