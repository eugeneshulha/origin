module CorevistAPI
  class Admin::FilterUserService < CorevistAPI::BaseService
    def initialize(object, params, query)
      super(object, params)
      @filter_result = CorevistAPI::Filters::UserFilter.new(object, params, query).run
    end

    def call
      result(@filter_result.data)
    end
  end
end
