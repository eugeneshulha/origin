module CorevistAPI
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def self.extra_column_names
      column_names
    end
  end
end
