module CorevistAPI
  class API::V1::Salesdocs::ItemsController < API::V1::BaseController
    include CorevistAPI::ItemSortable
  end
end
