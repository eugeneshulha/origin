module CorevistAPI
  module Forms
    class Summaries::SalesdocIndexForm < BaseForm
      def permitted_params
        %w[type]
      end
    end
  end
end
