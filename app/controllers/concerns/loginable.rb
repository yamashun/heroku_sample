module Loginable
  extend ActiveSupport::Concern

  def login(user)
    reset_session
    session[:user_id] = user.id
  end
end
