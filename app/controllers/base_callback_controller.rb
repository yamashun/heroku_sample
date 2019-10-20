class BaseCallbackController < ApplicationController
  before_action :check_login, :check_callback_params, only: %i(callback)

  def callback
    if base_client.update(code: call_back_params[:code])
      BaseClientService.new(base_client).login
      # TODO: change redirect path
      redirect_to root_path, notice: 'BASE APIへの接続が許可されました。'
    else
      # TODO: error handling
      redirect_to root_path, notice: 'BASE APIへの接続に失敗しました'
    end
  end

  private

  def call_back_params
    params.permit(:code, :state)
  end

  def check_login
    redirect_to sign_in_path and return unless logged_in?
  end

  def check_callback_params
    # TODO: change redirect path
    redirect_to root_path and return if call_back_params[:code].blank? || call_back_params[:state].blank?
    redirect_to root_path and return if base_client.auth_state != call_back_params[:state]
  end
end
