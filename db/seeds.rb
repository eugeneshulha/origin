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

  sales_area = CorevistAPI::SalesArea.find_or_create_by(
      title: '30001000',
      created_by: 'seeds',
      )

  role = CorevistAPI::Role.find_or_create_by!(
      title: 'Create Roles',
      description: 'That role lets you create roles',
      created_by: 'seeds',
      )

  doc_type = CorevistAPI::DocType.find_or_create_by!(
      title: 'TA',
      data: '',
      created_by: 'seeds',
  )

  %w[C I H M O P U B A].each do |c|
    dc = CorevistAPI::DocCategory.find_or_create_by!(id: c, created_by: 'seeds')
    dc.sales_areas << sales_area
  end

  user = CorevistAPI::User.create!(
      username: 'user_1',
      password: '123123123',
      email: 'yury.matusevich@corevist.com',
      first_name: 'First',
      last_name: 'Last',
      user_type: CorevistAPI::UserType.first,
      user_classification: CorevistAPI::UserClassification.first,
      microsite: CorevistAPI::Microsite.first,
      created_by: 'seeds'
  ) unless CorevistAPI::User.find_by(username: 'user_1')

  CorevistAPI::User.find_or_initialize_by(username: 'dummy_user') do |dummy_user|
    dummy_user.password = '123123123'
    dummy_user.email = Forgery('email').address
    dummy_user.first_name = Forgery('name').first_name
    dummy_user.last_name = Forgery('name').last_name
    dummy_user.user_type = CorevistAPI::UserType.first
    dummy_user.user_classification = CorevistAPI::UserClassification.first
    dummy_user.microsite = CorevistAPI::Microsite.first
    dummy_user.created_by = 'seeds'
    dummy_user.phone = '123456789'
    dummy_user.roles << role
  end.save

  role.sales_areas << sales_area
  doc_type.sales_areas << sales_area
  user.roles << role
end
