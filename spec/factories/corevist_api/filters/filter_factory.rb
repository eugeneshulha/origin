FactoryBot.define do
  factory :base_filter, class: 'CorevistAPI::Filters::BaseFilter' do
    object { create(:user) }
    params { {} }
    query { CorevistAPI::User }
    initialize_with { new(object, params, query) }
    skip_create
  end

  factory :user_filter, class: 'CorevistAPI::Filters::UserFilter' do
    object { create(:user) }
    params { {} }
    query { CorevistAPI::User }
    initialize_with { new(object, params, query) }
    skip_create
  end
end
