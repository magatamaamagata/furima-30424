FactoryBot.define do
  factory :order_credits do
    postcode { '153-0042' }
    prefecture_id { '4' }
    city { '堺' }
    address { '123-4567' }
    building { 'スカイ' }
    phone_number { '09064444306' }
    token { 'ooooooooooooo' }
  end
end
