# CorevistApi

## Rake tasks
#### Users
Activate a user
```
bundle exec rake app:users:activate -- -u <username>
``` 

#### SAP Maintenance
Remove all downtimes
```
bundle exec rake app:sap_downtimes:clear
``` 

#### Translations

Remove all translations from database
```
bundle exec rake app:translations:clear
``` 

Populate translations table with default translations
```
bundle exec rake app:translations:reset
```

#### Permissions

Remove all permissions from database
```
bundle exec rake app:permissions:clear
```

Create permissions in database
```
bundle exec rake app:permissions:create
```

Recreate (remove and create) permissions
```
bundle exec rake app:permissions:reset
```

Add a specific permission to a selected user
```ruby
bundle exec rake app:permissions:add -- -u <username> -p <permission_name>

# Example: bundle exec rake app:permissions:add -- -u user_1 -p user_maintenance 
```

Remove a specific permission from a selected user
```ruby
bundle exec rake app:permissions:remove -- -u <username> -p <permission_name>

# Example: bundle exec rake app:permissions:remove -- -u user_1 -p user_maintenance 
```

#### Database
 
Create databases from `database.yml` file
```
bundle exec rake db:create
```

Drop databases
```
bundle exec rake db:drop
```

Run migrations
```
bundle exec rake db:migrate
```

Fill database with test data from `seeds.rb`
```
bundle exec rake app:db:seed
```

Recreate database with test data `db:drop` + `db:create` + `db:migrate` + `app:db:seed`
```
bundle exec rake db:rebuild
```


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
