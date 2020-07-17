# STI table
module CorevistAPI
  class Theme::RegularColor < Theme::Configuration
    has_many :configurations

    validates_uniqueness_of :title
  end
end
