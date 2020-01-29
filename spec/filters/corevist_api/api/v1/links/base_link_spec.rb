describe CorevistAPI::Filters::Links::BaseLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_base_link) }

  it { is_expected.to_not be_nil }

  describe '#perform' do
    subject { instance.perform(data) }
    let(:data) { nil }

    it { expect { subject }.to raise_error(NotImplementedError) }
  end
end
