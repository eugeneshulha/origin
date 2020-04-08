module CorevistAPI
  module Services::Salesdoc::Question
    class Create < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        user = CorevistAPI::Context.current_user
        Mailer.submit_salesdoc_question(@form.to_json, user.to_json).deliver_later
        Admin::Mailer.submit_salesdoc_question(@form.to_json, user.to_json).deliver_later

        result
      end
    end
  end
end
