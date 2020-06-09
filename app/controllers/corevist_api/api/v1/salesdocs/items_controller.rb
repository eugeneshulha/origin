module CorevistAPI
  class API::V1::Salesdocs::ItemsController < API::V1::BaseController
    include CorevistAPI::ItemSortable
    include CorevistAPI::Downloadable
  end
end
