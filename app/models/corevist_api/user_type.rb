module CorevistAPI
  class UserType < ApplicationRecord
    self.table_name = 'user_types'

    has_many :users
  end
end
