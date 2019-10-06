class BaseClientsController < ApplicationController
  before_action :check_login, only: %i(new create)

  def new
    @base_client = BaseClient.new
  end

  def create
    @base_client = current_user.build_base_client(create_params.permit(:client_id, :client_secret))
    if create_params[:coupon_code]
      @base_client.base_coupons.build(code: create_params[:coupon_code])
    end

    if @base_client.save
      redirect_to base_clients_complete_path
    else
      render :new
    end
  end

  def complete; end

  private

  def create_params
    params.require(:base_client).permit(:client_id, :client_secret, :coupon_code)
  end

  def check_login
    redirect_to root_path unless logged_in?
  end
end
