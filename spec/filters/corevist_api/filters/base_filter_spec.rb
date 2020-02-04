describe CorevistAPI::Filters::BaseFilter, type: :model do
  let(:instance) { build(:api_v1_filters_base_filter) }

  it do
    expect(instance.instance_variable_get(:@result)).to be_a_kind_of(CorevistAPI::Filters::Results::BaseResult)
  end

  describe '#chain' do
    subject { described_class.chain }

    it { is_expected.to be_a_kind_of(CorevistAPI::Filters::Chains::BaseChain) }
  end

  describe '#chain_links' do
    subject { instance.chain_links }

    context 'when chain is blank' do
      before { allow(instance).to receive_message_chain('chain.blank?').and_return(true) }

      it { expect { subject }.to raise_error(StandardError) }
    end

    context 'when chain is not blank' do
      before { allow(instance).to receive_message_chain('chain.blank?').and_return(false) }

      it { expect { subject }.to_not raise_error }
    end
  end

  describe '#run' do
    subject { instance.run }

    it do
      expect(instance).to receive_message_chain('chain_links.each_with_object')
      subject
    end
  end

  describe '#chain' do
    subject { instance.send(:chain) }

    it do
      expect(described_class).to receive(:class_variable_get).with(:@@chain)
      subject
    end
  end
end
