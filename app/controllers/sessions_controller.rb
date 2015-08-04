class SessionsController < ApplicationController
  # Creates a user from Facebook or updates an existing one with his Facebook credentials
  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_url
  end
end
