require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/item.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/shipping_line.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/header.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/tracking_number.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/delivery.rb')

module CorevistAPI
  class Salesdoc
    include CorevistAPI::Document
  end
end
