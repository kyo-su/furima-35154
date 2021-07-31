class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @purchase_history_customer = PurchaseHistoryCustomer.new
  end

  def create
    @purchase_history_customer = PurchaseHistoryCustomer.new(customer_params)

    if @purchase_history_customer.valid?
      @purchase_history_customer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def customer_params
    params.require(:purchase_history_customer).permit(:post_number, :prefecture_id, :municipality, :address,
                                                      :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
