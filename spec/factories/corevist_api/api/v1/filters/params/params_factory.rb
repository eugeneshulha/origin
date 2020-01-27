FactoryBot.define do
  factory :api_v1_filters_params_base_params, class: 'CorevistAPI::API::V1::Filters::Params::BaseParams' do
    skip_create
    initialize_with { new({}) }
  end
end
