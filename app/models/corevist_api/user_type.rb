module CorevistAPI
  class UserType < ApplicationRecord
    self.table_name = 'user_types'

    has_many :users

    def to_s
      title
    end
  end
end
