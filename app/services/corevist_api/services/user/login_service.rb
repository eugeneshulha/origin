module CorevistAPI::Services::User
  class LoginService < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      resource = @params.warden.authenticate(@params.send(:auth_options))
      raise ServiceException.new('user not found') unless  resource

      # get_assigned_partners(resource) if resource.assigned_partners.present?

      # FastGettext.locale = resource.language
      @params.sign_in(:user, resource)

      result(resource)
    end

    def get_assigned_partners(resource)
      @rfc_result = rfc_service_for(:assigned_partners, resource, {}).call

      # get assigned sold tos and ship tos (only one type is possible)
      assigned_partners = resource.assigned_partners.where(function: %w[AG WE])

      #
      # all user's partners except sold tos and ship_tos that should be deleted,
      # because new partners will be created in next loops.
      #
      partners_to_drop = resource.partners.to_a
      assigned_partners.each do |a_p|

        # delete a valid partner from partners_to_drop array
        partners_to_drop.delete(a_p)

        partners_sales_data =
          @rfc_result.data[:partner_sales_data].find { |data| data.sa == a_p.sales_area.title && data.nr == a_p.number }

        # get list of partners should be built from FUNCTIONS_PARTNERS table.
        partners_to_build = @rfc_result.data[:functions_partners].select do |fp|
          fp.anr == a_p.number && fp.sa == a_p.sales_area.title
        end
        next if partners_to_build.blank?

        partners_to_build.flatten.each do |p_to_build|
          query = {
            number: p_to_build.nr,
            function: p_to_build.fct,
            sales_area_id: a_p.sales_area.id,
            parent_partner_id: a_p.id
          }

          # check if the partner to be build exists
          partner_from_db = CorevistAPI::Partner.find_by(query)

          #
          # if it exists then delete it from partners_to_drop array, cause it's valid
          # and go to the next iteration
          #
          partners_to_drop.delete(partner_from_db) && next if partner_from_db.present?

          rfc_partner_data = @rfc_result.data[:partners].find { |x| x.nr == p_to_build.nr }
          builder_params = {
            parent_partner_id: a_p.id,
            sales_area: a_p.sales_area,
            user: current_user,
            rfc_partner: rfc_partner_data,
            sales_data: partners_sales_data,
            function: p_to_build.fct,
            postal_addresses: @rfc_result.data[:postal_addresses],
            street_addresses: @rfc_result.data[:street_addresses],
            assigned: false
          }

          p_type = CorevistAPI::Constants::SAP::Common::FUNCTION_TO_NAMES_MAP[p_to_build.fct].pluralize
          assigned_partner_from_sap = @rfc_result.data["assigned_#{p_type}".to_sym].to_a
                                                 .select { |x| x.nr == p_to_build.nr && x.sa == p_to_build.sa  }

          builder_params[:assigned] = true if assigned_partner_from_sap.present?
          partner = build_partner(builder_params)
          partner.save!
        end
      end

      partners_to_drop.each(&:delete)
    end

    def build_partner(options = {})
      partner = builder_for(:partner, options).build do |builder|
        builder.with_base_params
        builder.with_postal_addresses
        builder.with_street_addresses
        builder.with_parent_partner
        builder.with_assigned_param
      end

      raise CorevistAPI::ServiceException.new(partner.errors.full_messages) unless partner.valid?

      partner
    end
  end
end
