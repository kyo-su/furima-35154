class Customer < ApplicationRecord
  belongs_to :purchase_history

  # ActiveHashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
