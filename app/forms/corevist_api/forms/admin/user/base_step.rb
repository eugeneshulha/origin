module CorevistAPI
  class Forms::Admin::User::BaseStep < CorevistAPI::Forms::BaseForm

    def validate!
      raise NotImplementedError
    end
  end
end
