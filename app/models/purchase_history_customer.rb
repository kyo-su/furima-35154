class PurchaseHistoryCustomer

  include ActiveModel::Model
  attr_accessor :post_number, :prefecture_id, :municipality, :address, :building_name, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :municipality
    validates :address
    validates :phone_number, numericality: { only_integer: true }
    validates :user_id
    validates :item_id
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    # 購入履歴を保存する
    purchase_history = PurchaseHistory.create(user_id: user_id, item_id: item_id)

    # 購入者情報を保存する
    Customer.create(post_number: post_number, prefecture_id: prefecture_id, municipality: municipality, 
                                address: address, building_name: building_name, phone_number: phone_number, purchase_history_id: purchase_history.id)
    
  end

end 