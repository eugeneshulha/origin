module CorevistAPI
  class Privilege < ApplicationRecord
    has_and_belongs_to_many :roles
  end
end