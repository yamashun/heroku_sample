class SessionsController < ApplicationController
  before_action :check_login, only: %i(new create)

  def new
    @registered_user = RegisteredUser.new
  end

  def create
    if vald_params?
      login(r_user.user)
      redirect_to root_path
    else
      @registered_user = RegisteredUser.new(
        mail_address: sign_in_params[:mail_address],
        password: sign_in_params[:password]
      )
      render :new
    end
  end

  def destroy

  end

  private

  def sign_in_params
    params.require(:registered_user).permit(:mail_address, :password)
  end

  def r_user
    @r_user ||= RegisteredUser.find_by(mail_address: sign_in_params[:mail_address])
  end

  def vald_params?
    @errors = []
    if sign_in_params[:mail_address].blank?
      @errors << 'メールアドレスを入力してください'
      return false
    end
    if sign_in_params[:password].blank?
      @errors << 'パスワードを入力してください'
      return false
    end
    if !r_user&.authenticate(sign_in_params[:password])
      @errors << 'メールアドレスかパスワードが違います'
      return false
    end
    true
  end

  def check_login
    redirect_to root_path if logged_in?
  end
end
