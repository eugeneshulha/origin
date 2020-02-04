describe CorevistAPI::Filters::Params::BaseParams, type: :model do
  let(:instance) { build(:api_v1_filters_params_base_params) }

  describe '#initialize' do
    it { expect(instance.instance_variable_get(:@data)).to_not be_nil }
  end

  describe '#extract!' do
    subject { instance.extract!(param_name) }

    context 'when param present in data' do
      let(:param_name) { :param_name }
      let(:param_value) { :param_value }

      before { instance.instance_variable_get(:@data)[param_name] = param_value }

      it { is_expected.to eql(param_value) }
    end

    context 'when param not present in data' do
      let(:param_name) { :param_name }

      it { is_expected.to be_nil }
    end
  end

  describe '#exists?' do
    subject { instance.exists?(param_name) }

    context 'when param present in data' do
      let(:param_name) { :param_name }
      let(:param_value) { :param_value }

      before { instance.instance_variable_get(:@data)[param_name] = param_value }

      it { is_expected.to be_truthy }
    end

    context 'when param not present in data' do
      let(:param_name) { :param_name }

      it { is_expected.to be_falsey }
    end
  end

  describe '#get' do
    subject { instance.get(param_name) }

    context 'when param present in data' do
      let(:param_name) { :param_name }
      let(:param_value) { :param_value }

      before { instance.instance_variable_get(:@data)[param_name] = param_value }

      it { is_expected.to eql(param_value) }
    end

    context 'when param not present in data' do
      let(:param_name) { :param_name }

      it { is_expected.to be_nil }
    end
  end

  describe '#get' do
    subject { instance.all }

    it { is_expected.to eql(instance.instance_variable_get(:@data)) }
  end
end
