FactoryBot.define do
  factory :api_v1_assigned_partner, class: 'CorevistAPI::AssignedPartner' do
    number { Forgery(:basic).number }
    name { Forgery(:name).industry }
    sales_area { Forgery(:basic).number(at_most: 8) }
    enabled { true }
    function { 'AG' }
    user { create(:api_v1_user) }

    trait :sold_to do
      function { 'AG' }
    end

    trait :ship_to do
      function { 'WE' }
    end
  end
end
