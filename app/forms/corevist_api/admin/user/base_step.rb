module CorevistAPI
  class BaseStep < CorevistAPI::BaseForm

    def validate!
      raise NotImplementedError
    end
  end
end
