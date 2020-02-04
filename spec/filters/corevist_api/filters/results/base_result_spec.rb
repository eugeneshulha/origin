describe CorevistAPI::Filters::Results::BaseResult do
  let(:instance) { build(:results_base_result) }

  describe '#data' do
    subject { instance.data }

    it { expect(subject).to eql(instance.instance_variable_get(:@query)) }
  end
end
