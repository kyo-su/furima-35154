class AddReferencesToPurchaseHistories < ActiveRecord::Migration[6.0]
  def change
    add_reference :purchase_histories, :customer, null: false, foreign_key: true
  end
end
