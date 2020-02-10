module RedmineSidekiq
  class WebConstraint
    def matches?(request)
      api_key = request.params[:key] || request.headers['X-Redmine-API-Key']

      if request.session[:user_id]
        User.find(request.session[:user_id]).allowed_to?(:manage_sidekiq, nil, global: true)
      elsif api_key
        Token.find_by!(value: api_key.to_s).user&.allowed_to?(:manage_sidekiq, nil, global: true)
      end
    end
  end
end
