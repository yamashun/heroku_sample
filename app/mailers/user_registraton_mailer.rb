class UserRegistratonMailer < ApplicationMailer
  def send_to_user(pre_user)
    @mail_address = pre_user.mail_address
    @verify_url = "#{Settings.base_url}/sign_up/confirm?token=#{pre_user.verify_token}"
    @token = pre_user.verify_token
    mail to: pre_user.mail_address,
         subject: 'メールアドレスご確認のお願い'
  end
end
