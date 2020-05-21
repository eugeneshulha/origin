module CorevistAPI
  class Permission < ApplicationRecord
    self.table_name = 'permissions'

    has_and_belongs_to_many :roles, -> { distinct }

    attr_accessor :active

    def active?
      !!active
    end

    def to_json(*_args)
      {}.tap { |hash| %i[id title description active].map { |key| hash[key] = send(key) } }
    end
  end
end
