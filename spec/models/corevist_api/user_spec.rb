describe CorevistAPI::User, type: :model do
  let!(:instance) { create(:api_v1_user) }

  it { is_expected.to_not be_nil }
end
