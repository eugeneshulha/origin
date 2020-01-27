describe CorevistAPI::API::V1::Filters::Links::UserClassificationLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_user_classification_link) }

  it { is_expected.to_not be_nil }

  describe '#perform' do
    subject { instance.perform(data) }

    context 'when params exclude classification' do
      let(:data) { build(:api_v1_filters_results_user_result, :without_classification) }

      it { is_expected.to be_nil }
      it do
        expect(data.query).to_not receive(:where).with(any_args)
        subject
      end
    end

    context 'when params include classification' do
      let(:data) { build(:api_v1_filters_results_user_result, :with_classification) }

      it { is_expected.to_not be_nil }
      it do
        expect(data.query).to receive(:where)
        subject
      end
    end
  end
end
