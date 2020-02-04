FactoryBot.define do
  factory :params_base_params, class: 'CorevistAPI::Filters::Params::BaseParams' do
    skip_create
    initialize_with { new({}) }
  end
end
