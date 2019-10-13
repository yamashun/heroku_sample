class RegistrationsController < ApplicationController
  before_action :check_login, only: %i(new send_confirm confirm)

  def new
    @pre_user_registration = PreUserRegistration.new
  end

  def send_confirm
    @pre_user_registration = PreUserRegistration.new(confirm_params)
    if @pre_user_registration.save
      send_registration_mail
    else
      render :new
    end
  end

  def confirm
    redirect_to root_path if params[:token].blank? || pre_user_registration.blank?

    ActiveRecord::Base.transaction do
      RegisteredUser.create!(
        user: User.create!,
        mail_address: pre_user_registration.mail_address,
        password_digest: pre_user_registration.password_digest,
        register_status: RegisteredUser.register_statuses[:registered]
      )
      pre_user_registration.registered!
    end
    redirect_to root_path, notice: 'アカウント登録が完了しました'
  end

  private

  def confirm_params
    params.require(:pre_user_registration).permit(:mail_address, :password)
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


  def send_registration_mail
    UserRegistratonMailer.send_to_user(@pre_user_registration).deliver_now
  end

  def check_login
    redirect_to root_path if logged_in?
  end

  def pre_user_registration
    @pre_user_registration ||= PreUserRegistration.find_by(verify_token: params[:token])
  end
end
