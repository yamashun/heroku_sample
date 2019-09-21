module Loginable
  extend ActiveSupport::Concern

  def login(user)
    reset_session
    session[:user_id] = user.id
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
