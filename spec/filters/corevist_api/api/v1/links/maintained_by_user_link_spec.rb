describe CorevistAPI::Filters::Links::MaintainedByUserLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_maintained_by_user_link) }

  it { is_expected.to_not be_nil }

  describe '#perform' do
    subject { instance.perform(data) }

    context 'when params exclude maintained by user' do
      let(:data) { build(:api_v1_filters_results_user_result, :without_maintained_by_user) }

      it { is_expected.to be_nil }
      it do
        expect(data.query).to_not receive(:where).with(any_args)
        subject
      end
    end

    context 'when params include maintained by user' do
      let(:data) { build(:api_v1_filters_results_user_result, :with_maintained_by_user) }

      it { is_expected.to_not be_nil }
      it do
        expect(data.query).to receive(:where).with(any_args)
        subject
      end
    end
  end
end
