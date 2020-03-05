# require "corevist_api/railtie"
require 'jbuilder'
require 'haml'
require 'devise'
require 'devise/jwt'
require 'pundit'
require 'sapnwrfc'
require 'sidekiq'
require 'config'
require 'rack/cors'
require 'corevist_api/engine'

module CorevistAPI
  extend ActiveSupport::Autoload

  module RFCServices
    extend ActiveSupport::Autoload

    autoload :BaseRFCService, CorevistAPI::Engine.root.join('app', 'rfc_services', 'corevist_api', 'rfc_services', 'base_rfc_service')

    module BaseRFC
      extend ActiveSupport::Autoload

      autoload :Result, CorevistAPI::Engine.root.join('app', 'rfc_services', 'corevist_api', 'rfc_services', 'base_rfc', 'rfc_service_result')
    end

    module Truncations
      extend ActiveSupport::Autoload

      autoload :RfcService, CorevistAPI::Engine.root.join('app', 'rfc_services', 'corevist_api', 'rfc_services', 'truncations', 'rfc_service')
      autoload :StructService, CorevistAPI::Engine.root.join('app', 'rfc_services', 'corevist_api', 'rfc_services', 'truncations', 'struct_service')
    end
  end

  module Services
    extend ActiveSupport::Autoload

    autoload :ServiceResult, CorevistAPI::Engine.root.join('app', 'services', 'corevist_api', 'services', 'service_result')
    autoload :BaseService, CorevistAPI::Engine.root.join('app', 'services', 'corevist_api', 'services', 'base_service')
    autoload :BaseServiceWithForm, CorevistAPI::Engine.root.join('app', 'services', 'corevist_api', 'services', 'base_service_with_form')
    autoload :BaseServiceInterface, CorevistAPI::Engine.root.join('app', 'services', 'corevist_api', 'services', 'concerns', 'base_service_interface')

    module OpenItems
      extend ActiveSupport::Autoload

      autoload :SearchService, CorevistAPI::Engine.root.join('app', 'services', 'corevist_api', 'services', 'open_items', 'search_service')
    end

    module Summaries
      module Salesdocs
        extend ActiveSupport::Autoload

        autoload :SearchService, CorevistAPI::Engine.root.join('app', 'services', 'corevist_api', 'services', 'summaries', 'salesdocs', 'search_service')
      end
    end

    module Base
      extend ActiveSupport::Autoload

      autoload :DestroyService, CorevistAPI::Engine.root.join('app', 'services', 'corevist_api', 'services', 'base', 'destroy_service')
      autoload :ShowService, CorevistAPI::Engine.root.join('app', 'services', 'corevist_api', 'services', 'base', 'show_service')
      autoload :UpdateService, CorevistAPI::Engine.root.join('app', 'services', 'corevist_api', 'services', 'base', 'update_service')
      autoload :IndexService, CorevistAPI::Engine.root.join('app', 'services', 'corevist_api', 'services', 'base', 'index_service')
    end
  end

  module Validators
    extend ActiveSupport::Autoload

    autoload :OneOutOfValidator, CorevistAPI::Engine.root.join('app', 'validators', 'corevist_api', 'validators', 'one_out_of_validator')
  end

  module Forms
    module Invoice; end
    module Salesdoc; end
    module User; end
    module Summaries
      extend ActiveSupport::Autoload

      autoload :SalesdocsForm, CorevistAPI::Engine.root.join('app', 'forms', 'corevist_api', 'forms', 'summaries', 'salesdocs_index_form')
    end

    module OpenItems
      extend ActiveSupport::Autoload

      autoload :IndexForm, CorevistAPI::Engine.root.join('app', 'forms', 'corevist_api', 'forms', 'open_items', 'index_form')
    end
  end

  module Factories
    extend ActiveSupport::Autoload

    autoload :FormsFactory, CorevistAPI::Engine.root.join('app', 'factories', 'corevist_api', 'factories', 'forms_factory')
    autoload :ServicesFactory, CorevistAPI::Engine.root.join('app', 'factories', 'corevist_api', 'factories', 'services_factory')
    autoload :BuildersFactory, CorevistAPI::Engine.root.join('app', 'factories', 'corevist_api', 'factories', 'builders_factory')
  end

  module Constants
    module SAP; end
  end

  module API
    module V1
      module Admin; end
    end
  end

  module Filters
    extend ActiveSupport::Autoload

    autoload :Common, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'filters', 'common')
    autoload :BaseFilter, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'filters', 'base_filter')
    autoload :UserFilter, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'filters', 'user_filter')
    autoload :RoleFilter, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'filters', 'role_filter')

    module Links
      extend ActiveSupport::Autoload

      links_path = CorevistAPI::Engine.root.join('app/filters/corevist_api/filters/links')

      autoload :BaseLink, links_path.join('base_link')
      autoload :AssignedPartnerLink, links_path.join('assigned_partner_link')
      autoload :AssignedPartnerOrPartnersLink, links_path.join('assigned_partner_or_partners_link')
      autoload :CriteriaLink, links_path.join('criteria_link')
      autoload :MaintainedByUserLink, links_path.join('maintained_by_user_link')
      autoload :MicrositeLink, links_path.join('microsite_link')
      autoload :OrderLink, links_path.join('order_link')
      autoload :PartnersLink, links_path.join('partners_link')
      autoload :RoleIdLink, links_path.join('role_id_link')
      autoload :UserClassificationLink, links_path.join('user_classification_link')
      autoload :UserStatusLink, links_path.join('user_status_link')
      autoload :UserTypeLink, links_path.join('user_type_link')
    end

    module Params
      extend ActiveSupport::Autoload

      autoload :BaseParams, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'filters', 'params', 'base_params')
    end

    module Results
      extend ActiveSupport::Autoload

      autoload :BaseResult, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'filters', 'results', 'base_result')
      autoload :UserResult, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'filters', 'results', 'user_result')
    end

    module Chains
      extend ActiveSupport::Autoload

      autoload :BaseChain, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'filters', 'chains', 'base_chain')
    end
  end

  module Builders
    extend ActiveSupport::Autoload

    autoload :BaseBuilder, CorevistAPI::Engine.root.join('app', 'builders', 'corevist_api', 'builders', 'base_builder')

    module Partners
      extend ActiveSupport::Autoload

      autoload :Builder, CorevistAPI::Engine.root.join('app', 'builders', 'corevist_api', 'builders', 'partners', 'builder')
    end
  end
end
