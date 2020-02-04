describe CorevistAPI::Filters::Links::UserTypeLink, type: :filter do
  let(:instance) { build(:links_user_type_link) }

  it { is_expected.to_not be_nil }

  describe '#perform' do
    subject { instance.perform(data) }

    context 'when object is not customer admin' do
      let(:data) { build(:results_user_result) }

      before { allow(data.object).to receive(:customer_admin?).and_return(false) }

      it { is_expected.to be_nil }
      it do
        expect(data.query).to_not receive(:where).with(any_args)
        subject
      end
    end

    context 'when object is customer admin' do
      let(:data) { build(:results_user_result) }

      before { allow(data.object).to receive(:customer_admin?).and_return(true) }

      it { is_expected.to_not be_nil }
      it do
        expect(data.query).to receive(:where).with(user_type: 'customer')
        subject
      end
    end
  end
end
