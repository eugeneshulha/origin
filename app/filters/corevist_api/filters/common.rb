module CorevistAPI
  module Filters::Common
    def by_assigned_partner(number, function, data)
      data.partners << data.query.joins(:assigned_partners).where(assigned_partners: { number: number, function: function })
    end
  end
end
