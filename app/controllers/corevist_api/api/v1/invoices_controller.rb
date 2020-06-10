module CorevistAPI
  class API::V1::InvoicesController < API::V1::BaseController
    include CorevistAPI::AsDocument
    include CorevistAPI::Downloadable
  end
end
