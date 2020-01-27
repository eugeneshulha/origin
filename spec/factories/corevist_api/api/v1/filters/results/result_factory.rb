FactoryBot.define do
  factory :api_v1_filters_results_base_result, class: 'CorevistAPI::API::V1::Filters::Results::BaseResult' do
    object { create(:api_v1_user) }
    params { {} }
    query { CorevistAPI::API::V1::User }
    initialize_with { new(object, params, query) }
    skip_create
  end

  factory :api_v1_filters_results_user_result, class: 'CorevistAPI::API::V1::Filters::Results::UserResult' do
    object { create(:api_v1_user) }
    params { {} }
    query { CorevistAPI::API::V1::User }
    skip_create
    initialize_with { new(object, params, query) }

    trait :without_partner_number_param do
      params { {} }
    end

    trait :with_partner_number_param do
      params { { sold_to_number: create(:api_v1_assigned_partner) } }
    end

    trait :without_partner_number do
      partner_number { nil }
    end

    trait :with_partner_number do
      partner_number { create(:api_v1_assigned_partner).number }
    end

    trait :with_sold_tos_and_ship_tos do
      object { create(:api_v1_user, :with_sold_tos_and_ship_tos) }
    end

    trait :with_sold_tos do
      object { create(:api_v1_user, :with_sold_tos) }
    end

    trait :with_ship_tos do
      object { create(:api_v1_user, :with_ship_tos) }
    end

    trait :with_valid_criteria do
      params { { 'username'.freeze => object.username } }
    end

    trait :with_invalid_criteria do
      params { { 'city'.freeze => 'LA' } }
    end

    trait :without_maintained_by_user do
      params { {} }
    end

    trait :with_maintained_by_user do
      params { { maintained_by_user: true } }
    end

    trait :without_partners do
      partners { [] }
    end

    trait :with_partners do
      partners { [create(:api_v1_assigned_partner)] }
    end

    trait :without_role_id do
      params { {} }
    end

    trait :with_role_id do
      params { { role_id: :role } }
    end

    trait :without_classification do
      params { {} }
    end

    trait :with_classification do
      params { { classification: :classification } }
    end

    trait :without_user_status do
      params { {} }
    end

    trait :with_valid_user_status do
      params { { user_status: 'incomplete' } }
    end

    trait :with_invalid_user_status do
      params { { user_status: 'invalid_status' } }
    end
  end
end
