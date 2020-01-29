FactoryBot.define do
  factory :api_v1_filters_links_base_link, class: 'CorevistAPI::Filters::Links::BaseLink' do
    skip_create
  end

  factory :api_v1_filters_links_assigned_partner_link,
          class: 'CorevistAPI::Filters::Links::AssignedPartnerLink' do
    skip_create
  end

  factory :api_v1_filters_links_assigned_partner_or_partners_link,
          class: 'CorevistAPI::Filters::Links::AssignedPartnerOrPartnersLink' do
    skip_create
  end

  factory :api_v1_filters_links_criteria_link,
          class: 'CorevistAPI::Filters::Links::CriteriaLink' do
    skip_create
  end

  factory :api_v1_filters_links_maintained_by_user_link,
          class: 'CorevistAPI::Filters::Links::MaintainedByUserLink' do
    skip_create
  end

  factory :api_v1_filters_links_microsite_link,
          class: 'CorevistAPI::Filters::Links::MicrositeLink' do
    skip_create
  end

  factory :api_v1_filters_links_order_link,
          class: 'CorevistAPI::Filters::Links::OrderLink' do
    skip_create
  end

  factory :api_v1_filters_links_partners_link,
          class: 'CorevistAPI::Filters::Links::PartnersLink' do
    skip_create
  end

  factory :api_v1_filters_links_role_id_link,
          class: 'CorevistAPI::Filters::Links::RoleIdLink' do
    skip_create
  end

  factory :api_v1_filters_links_user_classification_link,
          class: 'CorevistAPI::Filters::Links::UserClassificationLink' do
    skip_create
  end

  factory :api_v1_filters_links_user_status_link,
          class: 'CorevistAPI::Filters::Links::UserStatusLink' do
    skip_create
  end

  factory :api_v1_filters_links_user_type_link,
          class: 'CorevistAPI::Filters::Links::UserTypeLink' do
    skip_create
  end
end
