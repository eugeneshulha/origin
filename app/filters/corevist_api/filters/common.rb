module CorevistAPI
  module Filters::Common
    def by_assigned_partner(number, function, data)
      data.partners << data.query.joins(:partners).where(partners: { number: number, function: function, assigned: true })
    end
  end
end
