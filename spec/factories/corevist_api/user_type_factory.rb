FactoryBot.define do
  factory :user_type, class: 'CorevistAPI::UserType' do
    title { 'customer' }
    value { 'C' }
  end
end
