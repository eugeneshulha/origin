describe CorevistAPI::API::V1::Filters::Links::PartnersLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_partners_link) }

  it { is_expected.to_not be_nil }

  describe '#perform' do
    subject { instance.perform(data) }

    context 'when params partners are blank' do
      let(:data) { build(:api_v1_filters_results_user_result) }
      before { allow(data.partners).to receive(:blank?).and_return(true) }

      it { is_expected.to be_nil }
    end

    context 'when params partners are present' do
      let(:data) { build(:api_v1_filters_results_user_result, :with_partners) }

      it { is_expected.to_not be_nil }
      it do
        expect(data.query).to receive(:joins).with(:assigned_partners)
        subject
      end
      it do
        expect(data.query).to receive_message_chain('joins.where')
        subject
      end
    end
  end
end
