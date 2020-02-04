describe CorevistAPI::User, type: :model do
  let!(:instance) { create(:user) }

  it { is_expected.to_not be_nil }
end
