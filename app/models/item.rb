class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # ActiveHashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :charge_burden
  belongs_to :prefecture
  belongs_to :day

  # 空の投稿を保存できないようにする
  with_options presence: true do
    validates :title
    validates :description
    validates :price
  end

  # 選択肢「---」の時は保存できないようにする
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :charge_burden_id
    validates :prefecture_id
    validates :day_id
  end
end
