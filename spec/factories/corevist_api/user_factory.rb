FactoryBot.define do
  factory :user, class: 'CorevistAPI::User' do
    email { Forgery(:internet).email_address }
    username { Forgery(:internet).user_name }
    password { Forgery(:basic).password }
    first_name { Forgery(:name).first_name }
    last_name { Forgery(:name).last_name }
    microsite { create(:microsite) }
    user_type { create(:user_type) }
    user_classification { CorevistAPI::UserClassification.find_or_create_by(id: 'dealer') }

    trait :with_sold_tos_and_ship_tos do
      partners { [create(:partner, :sold_to), create(:partner, :ship_to)] }
    end

    trait :with_sold_tos do
      partners { [create(:partner, :sold_to)] }
    end

    trait :with_ship_tos do
      partners { [create(:partner, :ship_to)] }
    end
  end
end
