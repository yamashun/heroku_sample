class ApplicationController < ActionController::Base
  include Loginable
  include BaseApiHelper

  helper_method %i(current_user logged_in?)

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
