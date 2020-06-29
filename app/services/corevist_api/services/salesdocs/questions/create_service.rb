module CorevistAPI::Services::Salesdocs::Questions
  class CreateService < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      user = CorevistAPI::Context.current_user
      CorevistAPI::Mailer.submit_salesdoc_question(@form.as_json, user.uuid).deliver_later
      CorevistAPI::Admin::Mailer.submit_salesdoc_question(@form.as_json, user.uuid).deliver_later

      result
    end
  end
end
