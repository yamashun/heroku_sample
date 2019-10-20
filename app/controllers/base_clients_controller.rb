class BaseClientsController < ApplicationController
  before_action :check_login, only: %i(new create complete)
  before_action :check_base_info_registered, only: %i(complete)

  def new
    @base_client = BaseClient.new
  end

  def create
    @base_client = current_user.build_base_client(create_params.permit(:client_id, :client_secret))
    if create_params.permit(:coupon_code).present?
      @base_client.base_coupons.build(code: create_params.permit(:coupon_code))
    end

    if @base_client.save
      redirect_to base_clients_complete_path
    else
      render :new
    end
  end

  def complete
    base_client.update!(auth_state: SecureRandom.hex(10))
  end

  private

  def create_params
    params.require(:base_client)
  end

  def check_login
    redirect_to sign_in_path unless logged_in?
  end

  def check_base_info_registered
    redirect_to root_path if base_client.blank?
  end
end
