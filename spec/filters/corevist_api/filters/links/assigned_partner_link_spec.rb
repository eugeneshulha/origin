describe CorevistAPI::Filters::Links::AssignedPartnerLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_assigned_partner_link) }

  it { is_expected.to_not be_nil }
  it { expect(described_class.ancestors).to include(CorevistAPI::Filters::Common) }

  describe '#perform' do
    subject { instance.perform(data) }
    let(:data) { build(:api_v1_filters_results_user_result) }

    it { expect { subject }.to_not raise_error }

    context 'when data params exclude partner number criteria' do
      let(:data) { build(:api_v1_filters_results_user_result, :without_partner_number_param) }

      it { expect { subject }.to_not(change { data.partners }) }
    end

    context 'when data params include partner number criteria' do
      let(:data) { build(:api_v1_filters_results_user_result, :with_partner_number_param) }

      it { expect { subject }.to(change { data.partners }) }
    end
  end
end
