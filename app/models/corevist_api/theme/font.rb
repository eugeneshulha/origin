# STI table
module CorevistAPI
  class Theme::Font < Theme::Configuration
    has_many :configurations

    validates_uniqueness_of :title
  end
end
