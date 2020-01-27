describe CorevistAPI::API::V1::Filters::Links::CriteriaLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_criteria_link) }

  it { is_expected.to_not be_nil }

  describe '#perform' do
    subject { instance.perform(data) }

    context 'when params include valid criteria' do
      let(:data) { build(:api_v1_filters_results_user_result, :with_valid_criteria) }

      it do
        expect(data.query).to receive(:where).with(any_args)
        subject
      end
    end

    context 'when params include valid criteria' do
      let(:data) { build(:api_v1_filters_results_user_result, :with_invalid_criteria) }

      it do
        expect(data.query).to_not receive(:where).with(any_args)
        subject
      end
    end
  end
end
