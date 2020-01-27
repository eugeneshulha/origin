# require "corevist_api/railtie"
require 'jbuilder'
require 'haml'
require 'devise'
require 'devise/jwt'
require 'pundit'
require 'corevist_api/engine'

module CorevistAPI
  extend ActiveSupport::Autoload
  module API
    module V1
      extend ActiveSupport::Autoload

      autoload :User, CorevistAPI::Engine.root.join('app', 'models', 'corevist_api', 'api', 'v1', 'user')

      module Admin; end

      module Filters
        extend ActiveSupport::Autoload

        autoload :Common, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'api', 'v1', 'common')
        autoload :BaseFilter, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'api', 'v1', 'base_filter')
        autoload :UserFilter, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'api', 'v1', 'user_filter')

        module Links
          extend ActiveSupport::Autoload

          links_path = CorevistAPI::Engine.root.join('app/filters/corevist_api/api/v1/links')

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

          autoload :BaseParams, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'api', 'v1', 'params', 'base_params')
        end

        module Results
          extend ActiveSupport::Autoload

          autoload :BaseResult, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'api', 'v1', 'results', 'base_result')
          autoload :UserResult, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'api', 'v1', 'results', 'user_result')
        end

        module Chains
          extend ActiveSupport::Autoload

          autoload :BaseChain, CorevistAPI::Engine.root.join('app', 'filters', 'corevist_api', 'api', 'v1', 'chains', 'base_chain')
        end
      end
    end
  end
end
