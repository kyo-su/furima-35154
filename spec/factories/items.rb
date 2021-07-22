FactoryBot.define do
  factory :item do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    category_id { rand(2..11) }
    status_id { rand(2..7) }
    charge_burden_id { rand(2..3) }
    prefecture_id { rand(2..48) }
    day_id { rand(2..4) }
    price { rand(300..9999999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
