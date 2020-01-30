user = CorevistAPI::User.create!(
  username: 'user_1',
  password: '123123123',
  email: 'yury.matusevich@corevist.com',
  first_name: 'First',
  last_name: 'Last',
  microsite: 'microsite1',
  user_type: 'customer'
)

sales_area = CorevistAPI::SalesArea.create!(
  title: '3000',
  description: nil,
  created_by: 'Rake Task',
  updated_by: 'Rake Task',
  created_at: Time.zone.now,
  updated_at: Time.zone.now,
  active: false
)

role = CorevistAPI::Role.create!(
  title: 'Create Roles',
  description: 'That role lets you create roles',
  created_by: 'Rake Task',
  updated_by: 'Rake Task',
  created_at: Time.zone.now,
  updated_at: Time.zone.now,
  active: false
)

doc_type = CorevistAPI::DocType.create!(
  title: 'TA',
  description: nil,
  data: 'Doc type Data',
  created_by: 'Rake Task',
  updated_by: 'Rake Task',
  created_at: Time.zone.now,
  updated_at: Time.zone.now
)

doc_category = CorevistAPI::DocCategory.create!(
  id: '1',
  title: 'U',
  description: nil,
  created_by: 'Rake Task',
  updated_by: 'Rake Task',
  created_at: Time.zone.now,
  updated_at: Time.zone.now
)

role.users << user
role.sales_areas << sales_area
doc_type.sales_areas << sales_area
doc_category.sales_areas << sales_area
