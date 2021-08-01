class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @purchase_history_customer = PurchaseHistoryCustomer.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_history_customer = PurchaseHistoryCustomer.new(customer_params)
    @item = Item.find(params[:item_id])

    binding.pry
    if @purchase_history_customer.valid?
      pay_item
      @purchase_history_customer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def customer_params
    params.require(:purchase_history_customer).permit(:post_number, :prefecture_id, :municipality, :address,
                                                      :building_name, :phone_number)
                                                      .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp::api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: customer_params[:token],
        currency: 'jpy'
      )
  end
end
