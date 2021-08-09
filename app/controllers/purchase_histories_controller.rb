class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!, only: :index
  # before_action :move_to_root_seller, only: :index
  before_action :move_to_root_sold, only: :index
  before_action :set_item, only: [:index, :create]

  def index
    @purchase_history_customer = PurchaseHistoryCustomer.new
  end

  def create
    @purchase_history_customer = PurchaseHistoryCustomer.new(customer_params)

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

  def set_item
    @item = Item.find(params[:item_id])
  end

  # クレジット決済処理の記載
  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: customer_params[:token],
      currency: 'jpy'
    )
  end

  # ログイン状態のユーザーのアクセス制限（出品者）
  # def move_to_root_seller
  #   item = Item.find(params[:item_id])

  #   redirect_to root_path unless current_user.id == item.user.id
  # end

    # ログイン状態のユーザーのアクセス制限（売却済み）
    def move_to_root_sold
      set_item
      @purchase_history = PurchaseHistory.all
  
      redirect_to root_path if @purchase_history.exists?(item_id: @item.id)
    end
end
