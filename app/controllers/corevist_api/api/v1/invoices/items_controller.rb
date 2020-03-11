module CorevistAPI
  class API::V1::Invoices::ItemsController < API::V1::BaseController
    include CorevistAPI::ItemSortable
  end
end
