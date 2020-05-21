CorevistAPI::Managers::Download.setup do |config|
  config.apply_on << [:get, :download, CorevistAPI::API::V1::SalesdocsController]
  config.apply_on << [:get, :download, CorevistAPI::API::V1::InvoicesController]
  config.apply_on << [:get, :download, CorevistAPI::API::V1::Admin::UsersController]
  config.finalize!
end
