describe CorevistAPI::API::V1::Filters::Links::CriteriaLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_order_link) }

  it { is_expected.to_not be_nil }

  describe '#perform' do
    subject { instance.perform(data) }
    let(:data) { build(:api_v1_filters_results_user_result) }

    it do
      expect(data.query).to receive_message_chain('order.uniq').with(any_args)
      subject
    end
  end
end
