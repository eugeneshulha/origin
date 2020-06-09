module CorevistAPI
  class UserClassification < ApplicationRecord
    self.table_name = 'user_classifications'

    has_many :users

    def to_s
      title
    end
  end
end
