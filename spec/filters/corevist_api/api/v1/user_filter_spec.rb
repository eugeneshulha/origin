describe CorevistAPI::API::V1::Filters::UserFilter, type: :model do
  let(:instance) { build(:api_v1_filters_user_filter) }

  it do
    expect(instance.instance_variable_get(:@result)).to be_a_kind_of(CorevistAPI::API::V1::Filters::Results::BaseResult)
  end
end
