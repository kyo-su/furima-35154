FactoryBot.define do
  factory :user do
    gimei = Gimei.new

    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    # password              {Faker::Internet.password(min_length: 6)}
    password              { Faker::Lorem.characters(number: 8, min_alpha: 4, min_numeric: 1) }
    password_confirmation { password }
    family_name_kanji     { gimei.name.last.kanji }
    first_name_kanji      { gimei.name.first.kanji }
    family_name_kana      { gimei.name.last.katakana }
    first_name_kana       { gimei.name.first.katakana }
    birthday              { '2000-01-01' }
  end
end
