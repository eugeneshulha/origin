FactoryBot.define do
  factory :partner, class: 'CorevistAPI::Partner' do
    number { Forgery(:basic).number }
    name { Forgery(:name).industry }
    sales_area { create(:sales_area) }
    deleted { false }
    function { 'AG' }
    user { create(:user) }

    trait :sold_to do
      function { 'AG' }
    end

    trait :ship_to do
      function { 'WE' }
    end
  end
end
