require File.dirname(__FILE__) + '/lib/redmine_sidekiq/configure'
require File.dirname(__FILE__) + '/lib/redmine_sidekiq/rails'

Redmine::Plugin.register :redmine_sidekiq do
  name 'Redmine Sidekiq plugin'
  description 'This is a Sidekiq plugin for Redmine'
  version '2.1.0'
  url 'https://github.com/ogom/redmine_sidekiq'
  author_url 'mailto:ogom@hotmail.co.jp'
  author 'ogom'

  menu :top_menu, :sidekiq, '/sidekiq', :if => Proc.new {User.current.admin}

  project_module :redmine_sidekiq do
    permission :manage_sidekiq, sidekiq: :index
  end
end
