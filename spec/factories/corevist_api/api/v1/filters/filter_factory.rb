FactoryBot.define do
  factory :api_v1_filters_base_filter, class: 'CorevistAPI::API::V1::Filters::BaseFilter' do
    object { create(:api_v1_user) }
    params { {} }
    query { CorevistAPI::API::V1::User }
    initialize_with { new(object, params, query) }
    skip_create
  end

  factory :api_v1_filters_user_filter, class: 'CorevistAPI::API::V1::Filters::UserFilter' do
    object { create(:api_v1_user) }
    params { {} }
    query { CorevistAPI::API::V1::User }
    initialize_with { new(object, params, query) }
    skip_create
  end
end
