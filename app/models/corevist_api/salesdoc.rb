require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/item.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/shipping_line.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/header.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/tracking_number.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/delivery.rb')

module CorevistAPI
  class Salesdoc
    include CorevistAPI::Document

    # TODO: move to concerns/corevist_api/document.rb if relevant for any other document type
    attr_accessor :deliveries

    def initialize
      super
      @deliveries = []
    end
  end
end
