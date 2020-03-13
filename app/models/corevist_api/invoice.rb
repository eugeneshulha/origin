require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/invoice/item.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/invoice/payment_history.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/invoice/header.rb')


module CorevistAPI
  class Invoice
    include CorevistAPI::Document
  end
end
