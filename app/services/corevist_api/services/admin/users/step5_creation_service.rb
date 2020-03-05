module CorevistAPI
  module Services::Admin::Users
    class Step5CreationService < Step4CreationService
      private

      def function
        :sh
      end

      def excluded_function
        :sp
      end
    end
  end
end
