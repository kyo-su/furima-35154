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
    validates :image
  end

  # 選択肢「---」の時は保存できないようにする
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :charge_burden_id
    validates :prefecture_id
    validates :day_id
  end

  # 販売価格は整数であること、入力値が300~9,999,999であるか検証
  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000, allow_blank: true }
end
