require 'pry-byebug'

FactoryBot.define do
  factory :user_classification, class: 'CorevistAPI::UserClassification' do
    id { 'dealer' }
    title { 'dealer' }
  end
end
