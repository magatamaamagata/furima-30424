FactoryBot.define do
  factory :item do
    name { Faker::Name.initials(number: 39) }
    description { Faker::Lorem.sentence(word_count: 20) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id { Faker::Number.within(range: 2..11) }
    status_id       { Faker::Number.within(range: 2..7) }
    prefecture_id   { Faker::Number.within(range: 2..48) }
    shipment_fee_id { Faker::Number.within(range: 2..3) }
    day_to_ship_id { Faker::Number.within(range: 2..4) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
