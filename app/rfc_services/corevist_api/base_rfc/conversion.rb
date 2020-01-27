module CorevistAPI
  module BaseRFC::Conversion
    include CorevistAPI::Constants::Sap::Tables
    include CorevistAPI::Constants::Sap::Columns

    protected

    def object_to_rfc
      raise NotImplementedError
    end

    def array_to_rfc(assigns, options = {})
      rfc_key = options[:rfc_key]
      rfc_value = options[:rfc_value]
      assign_value = options[:assign_value]
      key_modifier = options.fetch(:key_modifier, :to_s)

      assigns.map do |key|
        value = assign_value.is_a?(Proc) ? assign_value.call(key) : assign_value
        { rfc_key => key.send(key_modifier), rfc_value => value }
      end
    end

    def hash_to_rfc(assigns, options = {})
      rfc_key = options[:rfc_key]
      rfc_value = options[:rfc_value]
      value_modifier = options.fetch(:value_modifier, :to_s)
      key_modifier = options.fetch(:key_modifier, :to_s)

      assigns.map do |key, values|
        values.map do |value|
          { rfc_key => key.send(key_modifier), rfc_value => value.send(value_modifier) }
        end
      end.flatten
    end

    def user_to_rfc(user)
      rfc_user = {
          USER_DATA => {
              USER_ID => user.user_id.to_s,
              FIRST_NAME => user.first_name.to_s,
              LAST_NAME => user.last_name.to_s,
              PHONE => user.db_user.phone.to_s,
              EMAIL => user.db_user.email_address.to_s,
              LANG => user.db_user.language.locale_to_sap,
              FI => user.fi_authorizations.to_s, # to_s to prevent nil for web services
              TYPE => user.db_user.user_type.first.upcase # C: customer and customer-admin, I: internal employee, S: system admin
          },
          ASSIGNED_SOLD_TOS => hash_to_rfc(user.assigned_sold_tos, rfc_key: NR, rfc_value: SA, key_modifier: :add_leading_zeros),
          ASSIGNED_SHIP_TOS => hash_to_rfc(user.assigned_ship_tos, rfc_key: NR, rfc_value: SA, key_modifier: :add_leading_zeros),
          ASSIGNED_PAYERS => hash_to_rfc(user.assigned_payers, rfc_key: NR, rfc_value: SA, key_modifier: :add_leading_zeros),
          ASSIGNED_TERRITORIES => hash_to_rfc(user.assigned_territories, rfc_key: NR, rfc_value: SA)
      }

      if microsite?
        rfc_user[USER_DATA][MICROSITE] = user.db_user.microsite.to_s.upcase
      end

      if user.user_type == UserB2b::B2C
        rfc_user[ASSIGNED_SALES_AREAS] = array_to_rfc(
            user.assigned_sales_areas,
            rfc_key: SA,
            rfc_value: DOC_CAT,
            assign_value: ABCIH
        )
        return compact_hash(rfc_user)
      end

      if user.master_role.blank?
        rfc_user[ASSIGNED_SALES_AREAS] = array_to_rfc(
            user.assigned_sales_areas,
            rfc_key: SA,
            rfc_value: DOC_CAT,
            assign_value: ABCIH
        )
      else
        rfc_user[ASSIGNED_SALES_AREAS] = array_to_rfc(
            user.assigned_sales_areas,
            rfc_key: SA,
            rfc_value: DOC_CAT,
            assign_value: lambda do |sales_area|
              user.master_role.sales_areas[sales_area.drop_leading_zeros].display_doc_categories
            end
        )
      end

      compact_hash(rfc_user)
    end

    def microsite?
      # We know we can send the microsite field in the user master if we are on the /COREVIST/ namespace
      # and have configured the text format fieldname.  Preference would be to check if MICROSITE was in rfc.parameters
      # but we do not have access from user model
      Const::App.configs[:text_format_fieldname] && Const::App.configs[:text_format_fieldname] == TEXT_FORMAT
    end

    # Hash#compact only in ruby 2.4+ and Rails 4+
    def compact_hash(hash)
      hash.select { |_, value| value.present? }
    end

    def values_to_s(hash)
      hash.map do |key, value|
        [key, value.to_s]
      end.to_h
    end

    def set_params(params)
      params.each do |param, value|
        next if @function.parameters[param].blank?
        @function.parameters[param].value = encode_struct(value, Encoding::ASCII_8BIT)
      end
    end

    def get_function_param(param_name)
      if @function.parameters[param_name].blank?
        return Hash.new
      end

      @function.parameters[param_name].value
    end

    def set_function_param(param_name, value)
      return if @function.parameters[param_name].blank?
      @function.parameters[param_name].value = value
    end

    def encode_function(encoding)
      @function.parameters.each_value do |value|
        next if value.value.blank?
        value.value = encode_struct(value.value, encoding)
      end
    end

    def encode_struct(struct, encoding)
      send("encode_#{struct.class.name.underscore}", struct, encoding)
    rescue
      struct
    end

    def encode_hash(hash, encoding)
      hash.each do |k, v|
        [k ,encode_struct(v, encoding)]
      end.to_h
    end

    def encode_array(array, encoding)
      array.map do |value|
        encode_struct(value, encoding)
      end
    end

    def encode_string(string, encoding)
      string.force_encoding(encoding)
    end
  end

end
