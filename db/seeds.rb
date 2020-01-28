CorevistAPI::User.create!(
  username: 'user_1',
  password: '123123123',
  email: 'yury.matusevich@corevist.com',
  first_name: 'First',
  last_name: 'Last',
  microsite: 'microsite1',
  user_type: 'customer'
)

CorevistAPI::Role.create!(
  name: 'Create Roles',
  created_by: 'Rake Task',
  updated_by: 'Rake Task',
  created_at: Time.zone.now,
  updated_at: Time.zone.now,
  active: false
)
