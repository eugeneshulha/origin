# STI table
module CorevistAPI
  class Theme::OpacityColor < Theme::Configuration
    has_many :configurations

    validates_uniqueness_of :title
  end
end
