describe CorevistAPI::Filters::Links::MicrositeLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_microsite_link) }

  it { is_expected.to_not be_nil }

  describe '#perform' do
    subject { instance.perform(data) }

    context 'when object is system admin' do
      let(:data) { build(:api_v1_filters_results_user_result) }
      before { allow(data.object).to receive(:system_admin?).and_return(true) }

      it { is_expected.to be_nil }
      it do
        expect(data.query).to_not receive(:where).with(any_args)
        subject
      end

      context 'when microsite count is equal 1' do
        before { allow(CorevistAPI::Microsite).to receive(:count).and_return(1) }

        it { is_expected.to be_nil }
        it do
          expect(data.query).to_not receive(:where).with(any_args)
          subject
        end
      end
    end

    context 'when object is not system admin' do
      let(:data) { build(:api_v1_filters_results_user_result) }
      before { allow(data.object).to receive(:system_admin?).and_return(false) }

      it { is_expected.to be_nil }

      context 'when microsite count is more than 1' do
        before { allow(CorevistAPI::Microsite).to receive(:count).and_return(2) }

        it { is_expected.to_not be_nil }
        it do
          expect(data.query).to receive(:where).with(any_args)
          subject
        end
      end
    end
  end
end
