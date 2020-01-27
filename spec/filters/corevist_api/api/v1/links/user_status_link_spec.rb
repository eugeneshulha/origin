describe CorevistAPI::API::V1::Filters::Links::UserStatusLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_user_status_link) }

  it { is_expected.to_not be_nil }

  describe '#perform' do
    subject { instance.perform(data) }

    context 'when params exclude user status' do
      let(:data) { build(:api_v1_filters_results_user_result, :without_user_status) }

      it { is_expected.to be_nil }
      it do
        expect(data.query).to_not receive(:where).with(any_args)
        subject
      end
    end

    context 'when params include include user status' do
      context 'when user status is valid' do
        let(:data) { build(:api_v1_filters_results_user_result, :with_valid_user_status) }

        it { is_expected.to_not be_nil }
        it do
          expect(data.query).to receive(:where)
          subject
        end
      end

      context 'when user status is invalid' do
        let(:data) { build(:api_v1_filters_results_user_result, :with_invalid_user_status) }

        it { is_expected.to be_nil }
        it do
          expect(data.query).to_not receive(:where)
          subject
        end
      end
    end
  end

  describe '#allow_to_search?' do
    subject { instance.send(:allow_to_search?, data) }

    context 'when user status is valid' do
      let(:data) { build(:api_v1_filters_results_user_result, :with_valid_user_status) }

      it { is_expected.to be_truthy }
    end

    context 'when user status is invalid' do
      let(:data) { build(:api_v1_filters_results_user_result, :with_invalid_user_status) }

      it { is_expected.to be_falsey }
    end
  end
end
