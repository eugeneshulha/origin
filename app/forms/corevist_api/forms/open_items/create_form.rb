module CorevistAPI::Forms::OpenItems
  class CreateForm < CorevistAPI::Forms::BaseForm
    attr_accessor :credit_card, :auth_token, :comp_code, :payer_number, :valid_on

    validate_component :create_payment_form, on_page: :open_items_create


    def pay_with_cc?
      @payment_method.downcase == 'c'
    end
  end
end
