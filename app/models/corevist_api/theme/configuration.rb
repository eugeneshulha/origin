module CorevistAPI
  class Theme::Configuration < ApplicationRecord
    self.table_name = 'theme_configurations'

    TYPES = %w[font regular_color opacity_color]

    belongs_to :theme

    validates_uniqueness_of :key
  end
end
