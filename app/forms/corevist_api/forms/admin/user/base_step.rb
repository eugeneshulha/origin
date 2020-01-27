module CorevistAPI
  class BaseStep < CorevistAPI::Forms::BaseForm

    def validate!
      raise NotImplementedError
    end
  end
end
