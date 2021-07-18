class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :status_id, :charge_burden_id, :prefecture_id, :day_id, :price).merge(user_id: current_user.id)
  end

end
