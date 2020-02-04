module CorevistAPI
  class UserClassification < ApplicationRecord
    self.table_name = 'user_classifications'

    has_many :users
  end
end
