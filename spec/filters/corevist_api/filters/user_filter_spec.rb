describe CorevistAPI::Filters::UserFilter, type: :model do
  let(:instance) { build(:user_filter) }

  it do
    expect(instance.instance_variable_get(:@result)).to be_a_kind_of(CorevistAPI::Filters::Results::BaseResult)
  end
end