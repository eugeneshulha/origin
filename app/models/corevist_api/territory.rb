module CorevistAPI
  class Territory < ApplicationRecord
    self.table_name = 'territories'

    has_and_belongs_to_many :microsites, before_add: :check_microsites

    validates_presence_of :territory, :title

    private

    def check_microsites(microsite)
      raise ActiveRecord::Rollback if microsites.include?(microsite)
    end
  end
end
