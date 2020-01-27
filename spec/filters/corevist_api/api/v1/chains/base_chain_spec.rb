describe CorevistAPI::API::V1::Filters::Chains::BaseChain, type: :filter do
  let(:instance) { build(:api_v1_filters_chains_base_chain) }

  it { is_expected.to be_a_kind_of(Array) }

  describe '#<<' do
    subject { instance.send(:<<, value) }

    context 'when value is not a kind of BaseLink' do
      let(:value) { nil }

      it { expect { subject }.to raise_error(StandardError) }
    end

    context 'when value is a kind of BaseLink' do
      let(:value) { :criteria_link }

      it { expect { subject }.to_not raise_error }
      it { expect { subject }.to(change { instance.size }.by(1)) }
    end
  end
end
