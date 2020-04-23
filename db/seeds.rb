# populate user classifications
ActiveRecord::Base.transaction do
  %w[distributor dealer enterprise].each do |c|
    CorevistAPI::UserClassification.find_or_create_by(id: c)
  end

  # populate user types
  # C: customer and customer-admin, I: internal employee, S: system admin
  { customer: 'C', customer_admin: 'C', translation_admin: 'C', system_admin: 'S', internal_employee: 'I' }.each do |k, v|
    CorevistAPI::UserType.find_or_create_by(title: k, value: v)
  end

  # populate microsites
  CorevistAPI::Microsite.find_or_create_by(name: 'microsite_1')

  # populate territories
  CorevistAPI::Territory.find_or_create_by(title: 'US blue chips, North West', territory: :W01) do |territory|
    territory.microsites << CorevistAPI::Microsite.first
  end.save

  sales_area_1 = CorevistAPI::SalesArea.find_or_create_by(
    title: '30001000',
    created_by: 'seeds'
  )

  sales_area_2 = CorevistAPI::SalesArea.find_or_create_by(
      title: '30001200',
      created_by: 'seeds'
  )

  sales_area_3 = CorevistAPI::SalesArea.find_or_create_by(
      title: '30001400',
      created_by: 'seeds'
  )

  sales_area_4 = CorevistAPI::SalesArea.find_or_create_by(
      title: '10001000',
      created_by: 'seeds'
  )

  role_1 = CorevistAPI::Role.find_or_create_by!(
    title: 'Create Roles',
    description: 'That role lets you create roles',
    created_by: 'seeds'
  )

  role_2 = CorevistAPI::Role.find_or_create_by!(
      title: 'View Roles',
      description: 'That role lets you create roles',
      created_by: 'seeds'
  )

  role_3 = CorevistAPI::Role.find_or_create_by!(
      title: 'View Invoices',
      description: 'That role lets you create roles',
      created_by: 'seeds'
  )

  role_4 = CorevistAPI::Role.find_or_create_by!(
      title: 'No view invoices',
      description: 'That role lets you create roles',
      created_by: 'seeds'
  )

  doc_type = CorevistAPI::DocType.find_or_create_by!(
    title: 'TA',
    data: '',
    created_by: 'seeds'
  )

  %w[C I H M O P U B A].each do |c|
    dc = CorevistAPI::DocCategory.find_or_create_by!(id: c, created_by: 'seeds')
    dc.sales_areas << sales_area_1
    dc.sales_areas << sales_area_2
    dc.sales_areas << sales_area_3
    dc.sales_areas << sales_area_4
  end

  CorevistAPI::User.find_or_initialize_by(username: 'user_1') do |user|
    user.username = 'user_1'
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'First'
    user.last_name = 'Last'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
  end.save

  %w[view_invoices search_for_invoices].each do |title|
    CorevistAPI::Permission.create!(title: title)
  end

  CorevistAPI::User.find_or_initialize_by(username: 'dummy_user') do |user|
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'First name'
    user.last_name = 'Last name'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.phone = '123456789'
    user.roles = [role_1]
  end.save

  CorevistAPI::Partner.new.tap do |payer|
    payer.user = CorevistAPI::User.find_by_username('user_1')
    payer.sales_area = sales_area_1
    payer.number = '0000003000'
    payer.function = 'RG'
    payer.state = 'NE'
    payer.country = 'US'
    payer.city = 'New York'
    payer.assigned = true
  end.save

  CorevistAPI::Partner.new.tap do |payer|
    payer.user = CorevistAPI::User.find_by_username('user_1')
    payer.sales_area = sales_area_1
    payer.number = '0000003001'
    payer.function = 'RG'
    payer.state = 'NE'
    payer.country = 'US'
    payer.city = 'New York'
    payer.assigned = true
  end.save

  CorevistAPI::Partner.new.tap do |payer|
    payer.user = CorevistAPI::User.find_by_username('user_1')
    payer.sales_area = sales_area_1
    payer.number = '0000003001'
    payer.function = 'AG'
    payer.state = 'NE'
    payer.country = 'US'
    payer.city = 'New York'
    payer.assigned = true
  end.save

  CorevistAPI::Partner.new.tap do |payer|
    payer.user = CorevistAPI::User.find_by_username('user_1')
    payer.sales_area = sales_area_1
    payer.number = '0000003050'
    payer.function = 'RG'
    payer.state = 'NE'
    payer.country = 'US'
    payer.city = 'New York'
    payer.assigned = true
  end.save

  CorevistAPI::Partner.new.tap do |sold_to|
    sold_to.user = CorevistAPI::User.find_by_username('user_1')
    sold_to.sales_area = sales_area_1
    sold_to.number = '0000003000'
    sold_to.function = 'AG'
    sold_to.state = 'NE'
    sold_to.country = 'US'
    sold_to.city = 'New York'
    sold_to.assigned = true
  end.save

  role_1.sales_areas.delete_all
  role_2.sales_areas.delete_all
  role_3.sales_areas.delete_all
  role_4.sales_areas.delete_all

  doc_type.sales_areas.delete_all
  role_1.permissions.delete_all
  role_2.permissions.delete_all
  role_3.permissions.delete_all
  role_4.permissions.delete_all

  role_1.sales_areas << sales_area_1
  role_1.sales_areas << sales_area_2
  role_1.sales_areas << sales_area_3
  role_1.sales_areas << sales_area_4

  role_3.sales_areas << sales_area_1
  role_4.sales_areas << sales_area_1

  doc_type.sales_areas << sales_area_1
  doc_type.sales_areas << sales_area_2
  doc_type.sales_areas << sales_area_3
  doc_type.sales_areas << sales_area_4

  role_1.permissions << CorevistAPI::Permission.all
  role_2.permissions << CorevistAPI::Permission.all
  role_3.permissions << CorevistAPI::Permission.find_by(title: 'view_invoices')

  u = CorevistAPI::User.find_by(username: 'user_1')
  u.roles.delete_all
  u.roles << role_1 if u.roles.blank?


  CorevistAPI::User.find_or_initialize_by(username: 'b2b') do |user|
    user.username = 'b2b'
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'b2b first name'
    user.last_name = 'b2b last name'
    user.user_type = CorevistAPI::UserType.find_by(value: 'S')
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [role_1]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_view_invoices') do |user|
    user.username = 'user_view_invoices'
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'User'
    user.last_name = '2'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [role_3]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_no_view_invoices') do |user|
    user.username = 'user_no_view_invoices'
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'User'
    user.last_name = '2'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [role_4]
  end.save
end

