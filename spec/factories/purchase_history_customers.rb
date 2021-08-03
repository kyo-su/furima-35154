FactoryBot.define do
  factory :purchase_history_customer do
    post_number { '123-4567' }
    prefecture_id { rand(2..48) }
    municipality { '渋谷区' }
    address { '青山1-1-1' }
    building_name { '柳ビル103' }
    phone_number { '09012345678' }
    token { 'token' }
  end
end
