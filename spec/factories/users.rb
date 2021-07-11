FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    # password              {Faker::Internet.password(min_length: 6)}
    password              { Faker::Lorem.characters(number: 8, min_alpha: 4, min_numeric: 1) }
    password_confirmation { password }
    family_name_kanji     { Gimei.last.kanji }
    first_name_kanji      { Gimei.first.kanji }
    family_name_kana      { Gimei.last.katakana }
    first_name_kana       { Gimei.first.katakana }
    birthday              { '2000-01-01' }
  end
end
