class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :move_to_root_sold, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @item = Item.order('created_at DESC')
    @purchase_history = PurchaseHistory.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @purchase_history = PurchaseHistory.all
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :status_id, :charge_burden_id, :prefecture_id,
                                 :day_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    set_item

    redirect_to root_path unless current_user.id == @item.user.id
  end

  # ログイン状態のユーザーのアクセス制限（売却済み）
  def move_to_root_sold
    set_item
    @purchase_history = PurchaseHistory.all

    redirect_to root_path if @purchase_history.exists?(item_id: @item.id)
  end
end
