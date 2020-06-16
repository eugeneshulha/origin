module CorevistAPI
  class SalesArea < ApplicationRecord
    default_scope { includes(:doc_types, :doc_categories) }

    include CorevistAPI::UserTrackable

    self.table_name = 'sales_areas'

    has_many :partners
    has_and_belongs_to_many :microsites
    has_and_belongs_to_many :doc_categories
    has_and_belongs_to_many :doc_types

    validates :title, uniqueness: { message: N_('error|attributes.name.not_uniq') }

    #
    # Sales area can not be deleted if it has partners in DB assigned to a user.
    #
    before_destroy :check_assigned_partners

    def as_json(*_args)
      super.tap { |hash| %i[doc_types doc_categories ].map { |key| hash[key] = send(key) } }
    end

    def self.extra_column_names
      super << 'doc_type_ids' << 'doc_category_ids'
    end

    private

    def check_assigned_partners
      if self.partners.where(assigned: true).where.not(function: 'RG').any?
        raise StandardError.new(_('error|sales area has assigned partners'))
      end
    end
  end
end
