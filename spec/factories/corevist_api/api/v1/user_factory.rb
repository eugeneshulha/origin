FactoryBot.define do
  factory :api_v1_user, class: 'CorevistAPI::API::V1::User' do
    email { Forgery(:internet).email_address }
    username { Forgery(:internet).user_name }
    password { Forgery(:basic).password }
    first_name { Forgery(:name).first_name }
    last_name { Forgery(:name).last_name }
    microsite { create(:microsite) }
    user_type { 'customer' }

    trait :with_sold_tos_and_ship_tos do
      assigned_partners { [create(:api_v1_assigned_partner, :sold_to), create(:api_v1_assigned_partner, :ship_to)] }
    end

    trait :with_sold_tos do
      assigned_partners { [create(:api_v1_assigned_partner, :sold_to)] }
    end

    trait :with_ship_tos do
      assigned_partners { [create(:api_v1_assigned_partner, :ship_to)] }
    end
  end
end
