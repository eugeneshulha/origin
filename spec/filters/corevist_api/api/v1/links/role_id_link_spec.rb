describe CorevistAPI::Filters::Links::RoleIdLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_role_id_link) }

  it { is_expected.to_not be_nil }

  describe '#perform' do
    subject { instance.perform(data) }

    context 'when params exclude role id' do
      let(:data) { build(:api_v1_filters_results_user_result, :without_role_id) }

      it { is_expected.to be_nil }
      it do
        expect(data.query).to_not receive(:where).with(any_args)
        subject
      end
    end

    context 'when params include role id' do
      let(:data) { build(:api_v1_filters_results_user_result, :with_role_id) }

      it { is_expected.to_not be_nil }
      it do
        expect(data.query).to receive_message_chain('joins.where')
        subject
      end
    end
  end
end
