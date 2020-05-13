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
  microsite_1 = CorevistAPI::Microsite.find_or_create_by(name: 'microsite_1')

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

  role_4 = CorevistAPI::Role.find_or_create_by!(
    title: 'No view invoices',
    description: 'That role lets you create roles',
    created_by: 'seeds'
  )

  open_items_role = CorevistAPI::Role.find_or_create_by!(
      title: 'Open Items',
      description: 'That role lets you see Open Items',
      created_by: 'seeds'
  )

  role_maintenance_role = CorevistAPI::Role.find_or_create_by!(
      title: 'Role Maintenance',
      description: 'That role lets you manage roles',
      created_by: 'seeds'
  )

  search_for_invoices_role = CorevistAPI::Role.find_or_create_by!(
      title: 'Search for invoices',
      description: 'That role lets you Search for invoices',
      created_by: 'seeds'
  )

  search_for_orders_role = CorevistAPI::Role.find_or_create_by!(
      title: 'Search for Orders',
      description: 'That role lets you Search for Orders',
      created_by: 'seeds'
  )

  translation_maintenance_role = CorevistAPI::Role.find_or_create_by!(
      title: 'Translation Maintenance',
      description: 'That role lets you manage translation',
      created_by: 'seeds'
  )

  user_maintenance_role = CorevistAPI::Role.find_or_create_by!(
      title: 'Roles Maintenance',
      description: 'That role lets you manage roles',
      created_by: 'seeds'
  )

  view_invoices_role = CorevistAPI::Role.find_or_create_by!(
      title: 'View Invoices',
      description: 'That role lets you View Invoices',
      created_by: 'seeds'
  )

  view_orders_role = CorevistAPI::Role.find_or_create_by!(
      title: 'View Orders',
      description: 'That role lets you View Orders',
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
    user.roles = [role_1]
  end.save

  %w[open_items
     role_maintenance
     search_for_invoices
     search_for_orders
     translation_maintenance
     user_maintenance
     view_invoices
     view_orders].each do |title|
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

  doc_type.sales_areas.delete_all

  role_1.permissions.delete_all
  role_2.permissions.delete_all
  role_4.permissions.delete_all
  open_items_role.permissions.delete_all
  role_maintenance_role.permissions.delete_all
  search_for_invoices_role.permissions.delete_all
  search_for_orders_role.permissions.delete_all
  translation_maintenance_role.permissions.delete_all
  user_maintenance_role.permissions.delete_all
  view_invoices_role.permissions.delete_all
  view_orders_role.permissions.delete_all

  microsite_1.sales_areas << sales_area_1
  microsite_1.sales_areas << sales_area_2
  microsite_1.sales_areas << sales_area_3
  microsite_1.sales_areas << sales_area_4

  doc_type.sales_areas << sales_area_1
  doc_type.sales_areas << sales_area_2
  doc_type.sales_areas << sales_area_3
  doc_type.sales_areas << sales_area_4

  role_1.permissions << CorevistAPI::Permission.all
  role_2.permissions << CorevistAPI::Permission.all
  view_invoices_role.permissions << CorevistAPI::Permission.find_by(title: 'view_invoices')
  open_items_role.permissions << CorevistAPI::Permission.find_by(title: 'open_items')
  role_maintenance_role.permissions << CorevistAPI::Permission.find_by(title: 'role_maintenance')
  search_for_invoices_role.permissions << CorevistAPI::Permission.find_by(title: 'search_for_invoices')
  search_for_orders_role.permissions << CorevistAPI::Permission.find_by(title: 'search_for_orders')
  translation_maintenance_role.permissions << CorevistAPI::Permission.find_by(title: 'translation_maintenance')
  user_maintenance_role.permissions << CorevistAPI::Permission.find_by(title: 'user_maintenance')
  view_invoices_role.permissions << CorevistAPI::Permission.find_by(title: 'view_invoices')
  view_orders_role.permissions << CorevistAPI::Permission.find_by(title: 'view_orders')

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
    user.roles = [view_invoices_role]
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

  CorevistAPI::User.find_or_initialize_by(username: 'user_search_for_invoices') do |user|
    user.username = 'user_search_for_invoices'
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'search_for_invoices'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [search_for_invoices_role]
  end.save


  # /api/v1/open_items  error payer  does not exist in allowed comp.codes
  CorevistAPI::User.find_or_initialize_by(username: 'user_open_items') do |user|
    user.username = 'user_open_items'
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'open_items'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [open_items_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_role_maintenance') do |user|
    user.username = 'user_role_maintenance'
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'role_maintenance'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [role_maintenance_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_search_for_invoices') do |user|
    user.username = 'user_search_for_invoices'
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'search_for_invoices'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [search_for_invoices_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_search_for_orders') do |user|
    user.username = 'user_search_for_orders'
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'search_for_orders'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [search_for_orders_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_translation_maintenance') do |user|
    user.username = 'user_translation_maintenance'
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'translation_maintenance'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [translation_maintenance_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_user_maintenance') do |user|
    user.username = 'user_user_maintenance'
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'user_maintenance'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [user_maintenance_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_view_invoices') do |user|
    user.username = 'user_view_invoices'
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'view_invoices'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [view_invoices_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_view_orders') do |user|
    user.username = 'user_view_orders'
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'view_orders'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'seeds'
    user.roles = [view_orders_role]
  end.save

end

