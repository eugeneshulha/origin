module CorevistAPI
  class Forms::Invoice::Pay < CorevistAPI::Forms::BaseForm
    attr_accessor :credit_card, :auth_token

    validate_component :create_payment_form, on_page: :payments_create


    def pay_with_cc?
      @payment_method.downcase == 'c'
    end
  end
end
