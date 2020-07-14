# populate user classifications
ActiveRecord::Base.transaction do
  %w[distributor dealer enterprise].each do |c|
    if CorevistAPI::UserClassification.find_by(id: c)
      puts "User classification #{c} found"
    else
      CorevistAPI::UserClassification.create!(id: c)
      puts "User classification #{c} created"
    end
  end

  # populate user types
  # C: customer and customer-admin, I: internal employee, S: system admin
  { customer: 'C', customer_admin: 'C', translation_admin: 'C', system_admin: 'S', internal_employee: 'I' }.each do |k, v|
    CorevistAPI::UserType.find_or_create_by(title: k, value: v)
    if CorevistAPI::UserType.find_by(title: k, value: v)
      puts "User type #{k} found"
    else
      CorevistAPI::UserType.create!(title: k, value: v)
      puts "User type #{k} created!"
    end
  end

  # populate microsites
  microsite_1 = CorevistAPI::Microsite.find_by(name: 'microsite_1')
  if microsite_1.blank?
    microsite_1 = CorevistAPI::Microsite.create(name: 'microsite_1')
    puts "Microsite \"#{microsite_1.name}\" created!"
  end

  # populate territories
  CorevistAPI::Territory.find_or_create_by(title: 'US blue chips, North West', territory: :W01) do |territory|
    territory.microsites = [CorevistAPI::Microsite.first]
  end.save

  sales_areas = %w[30001000 30001200 30001400 10001000]
  sales_areas.each_with_index do |s_a, index|
    sales_area = CorevistAPI::SalesArea.find_by(title: s_a)
    instance_variable_set("@sales_area_#{index}", sales_area) && next if sales_area

    sales_area = CorevistAPI::SalesArea.create!(title: s_a, created_by: 'system')
    instance_variable_set("@sales_area_#{index}", sales_area)
    puts "Sales area \"#{sales_area.title}\" created!"
  end

  #
  # list of permissions to build permissions and roles
  # Permission name "view_orders" gets converted to role View Orders
  # Roles in seeds file are stored in variables created from permission name
  # Permission name "pay_invoices" -> Role variable @pay_invoices_role
  #
  permissions = %w[
      open_items
      search_for_invoices
      search_for_orders
      search_for_payments
      view_invoices
      view_orders
      pay_invoices
      translation_maintenance
      user_maintenance
      role_maintenance
      system_maintenance
      content_maintenance
      doc_type_maintenance
      look_and_feel_maintenance
      login_when_sap_is_down
    ]

  permissions.each do |title|
    if CorevistAPI::Permission.find_by(title: title)
      puts "Permission #{title} exists!"
    else
      CorevistAPI::Permission.create!(title: title)
      puts "Permission #{title} created!"
    end
  end

  permissions.each do |title|
    if (role = CorevistAPI::Role.find_by(title: title.titleize))
      instance_variable_set("@#{title}_role", role)
      puts "Role '#{title.titleize}' found!"
    else
      role = CorevistAPI::Role.create!(title: title.titleize, active: true)
      role.permissions = [CorevistAPI::Permission.find_by(title: title)]
      instance_variable_set("@#{title}_role", role)
      puts "Role #{title.titleize} created!"
    end
  end

  doc_type = CorevistAPI::DocType.find_or_create_by!(
    title: 'TA',
    data: '',
    created_by: 'system'
  )

  %w[C I H M O P U B A].each do |c|
    dc = CorevistAPI::DocCategory.find_or_create_by!(id: c, created_by: 'system')
    dc.sales_areas = [@sales_area_0, @sales_area_1, @sales_area_2, @sales_area_3]
  end

  CorevistAPI::User.find_or_initialize_by(username: 'user_1') do |user|
    user.active = true
    user.username = 'user_1'
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'First'
    user.last_name = 'Last'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = CorevistAPI::Role.all
  end.save

  @user_1 = CorevistAPI::User.find_by(username: 'user_1')

  CorevistAPI::User.find_or_initialize_by(username: 'dummy_user') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'First name'
    user.last_name = 'Last name'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.phone = '123456789'
    user.roles = CorevistAPI::Role.all
  end.save

  CorevistAPI::Partner.find_or_initialize_by(number: '0000003000', sales_area_id: @sales_area_0.id, user_id: @user_1.id, function: 'RG') do |payer|
    payer.state = 'NE'
    payer.country = 'US'
    payer.city = 'New York'
    payer.assigned = true
  end.save

  CorevistAPI::Partner.find_or_initialize_by(number: '0000003001', sales_area_id: @sales_area_0.id, user_id: @user_1.id, function: 'RG') do |payer|
    payer.state = 'NE'
    payer.country = 'US'
    payer.city = 'New York'
    payer.assigned = true
  end.save

  CorevistAPI::Partner.find_or_initialize_by(number: '0000003001', sales_area_id: @sales_area_0.id, user_id: @user_1.id, function: 'AG') do |payer|
    payer.state = 'NE'
    payer.country = 'US'
    payer.city = 'New York'
    payer.assigned = true
  end.save

  CorevistAPI::Partner.find_or_initialize_by(number: '0000003050', sales_area_id: @sales_area_0.id, user_id: @user_1.id, function: 'RG') do |payer|
    payer.state = 'NE'
    payer.country = 'US'
    payer.city = 'New York'
    payer.assigned = true
  end.save

  CorevistAPI::Partner.find_or_initialize_by(number: '0000003000', sales_area_id: @sales_area_0.id, user_id: @user_1.id, function: 'AG') do |payer|
    payer.state = 'NE'
    payer.country = 'US'
    payer.city = 'New York'
    payer.assigned = true
  end.save

  microsite_1.sales_areas = [@sales_area_0, @sales_area_1, @sales_area_2, @sales_area_3]
  doc_type.sales_areas = [@sales_area_0, @sales_area_1, @sales_area_2, @sales_area_3]

  CorevistAPI::User.find_or_initialize_by(username: 'b2b') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'b2b first name'
    user.last_name = 'b2b last name'
    user.user_type = CorevistAPI::UserType.find_by(value: 'S')
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = CorevistAPI::Role.all
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_view_invoices') do |user|
    user.active = true
    user.username = 'user_view_invoices'
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'User'
    user.last_name = '2'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@view_invoices_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_no_view_invoices') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'User'
    user.last_name = '2'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@open_items_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_search_for_invoices') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'search_for_invoices'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@search_for_invoices_role]
  end.save


  # /api/v1/open_items  error payer  does not exist in allowed comp.codes
  CorevistAPI::User.find_or_initialize_by(username: 'user_open_items') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'open_items'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@open_items_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_role_maintenance') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'role_maintenance'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@role_maintenance_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_search_for_invoices') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'search_for_invoices'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@search_for_invoices_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_search_for_orders') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'search_for_orders'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@search_for_orders_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_translation_maintenance') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'translation_maintenance'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@translation_maintenance_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_user_maintenance') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'user_maintenance'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@user_maintenance_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_view_invoices') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'view_invoices'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@view_invoices_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_view_orders') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'andrei.klepets@corevist.com'
    user.first_name = 'User'
    user.last_name = 'view_orders'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = [@view_orders_role]
  end.save

  CorevistAPI::User.find_or_initialize_by(username: 'user_0') do |user|
    user.active = true
    user.password = '123123123'
    user.email = 'yury.matusevich@corevist.com'
    user.first_name = 'single'
    user.last_name = 'sold to'
    user.user_type = CorevistAPI::UserType.first
    user.user_classification = CorevistAPI::UserClassification.first
    user.microsite = CorevistAPI::Microsite.first
    user.created_by = 'system'
    user.roles = CorevistAPI::Role.all
  end.save

  @user_0 = CorevistAPI::User.find_by(username: 'user_0')

  CorevistAPI::Partner.find_or_initialize_by(number: '0000003000', sales_area_id: @sales_area_0.id, user_id: @user_0.id, function: 'AG') do |payer|
    payer.state = 'NE'
    payer.country = 'US'
    payer.city = 'New York'
    payer.assigned = true
  end.save

  connection_1 = {
      title: 'DEMO SAP', description: '', mshost: '', ashost: '172.20.3.2', sysnr: '00', client: '400',
      user: 'core_cpic', passwd: 'b2b4you', lang: 'EN', trace: '0', loglevel: '', active: true, env: :qa
  }

  CorevistAPI::SAPConnection.find_or_create_by(connection_1)

  localhost_connection_2 = {
      title: 'DEMO SAP', description: '', mshost: '', ashost: 'localhost', sysnr: '00', client: '400',
      user: 'core_cpic', passwd: 'b2b4you', lang: 'EN', trace: '0', loglevel: '', active: true, env: :development
  }

  CorevistAPI::SAPConnection.find_or_create_by(localhost_connection_2)
end
