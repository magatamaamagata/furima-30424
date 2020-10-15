FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 4) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 7, mix_case: true) }
    password_confirmation { password }
    gimei = Gimei.name
    family_name_kanji      { gimei.last.kanji }
    first_name_kanji       { gimei.first.kanji }
    family_name_katakana   { gimei.last.katakana }
    first_name_katakana    { gimei.first.katakana }
    birthday { Faker::Date.in_date_period }
  end
end
