describe CorevistAPI::API::V1::Filters::Links::AssignedPartnerOrPartnersLink, type: :filter do
  let(:instance) { build(:api_v1_filters_links_assigned_partner_or_partners_link) }

  it { is_expected.to_not be_nil }
  it { expect(described_class.ancestors).to include(CorevistAPI::API::V1::Filters::Common) }

  describe '#perform' do
    subject { instance.perform(data) }

    context 'when data partner number present' do
      let(:data) { build(:api_v1_filters_results_user_result, :with_partner_number) }

      it { is_expected.to be_nil }

      context 'when customer admin' do
        before { allow(data.object).to receive(:customer_admin?).and_return(true) }

        it { is_expected.to be_nil }
      end
    end

    context 'when data partner number absent' do
      let(:data) { build(:api_v1_filters_results_user_result, :without_partner_number, :with_sold_tos_and_ship_tos) }

      context 'when customer admin' do
        before { allow(data.object).to receive(:customer_admin?).and_return(true) }

        context 'when customer admins can maintain' do
          before { allow(instance).to receive(:customer_admins_can_maintain?).and_return(true) }

          it { expect { subject }.to(change { data.partners }) }
          it do
            subject
            expect(data.partners.size).to eql(data.object.assigned_partners.size)
          end
        end

        context 'when customer admins cannot maintain' do
          before { allow(instance).to receive(:customer_admins_can_maintain?).and_return(false) }

          context 'when object assigned sold tos empty' do
            let(:data) { build(:api_v1_filters_results_user_result, :without_partner_number, :with_ship_tos) }

            it { expect { subject }.to(change { data.partners }) }
            it do
              subject
              expect(data.partners.size).to eql(data.object.assigned_partners.size)
            end
          end

          context 'when object assigned sold tos present' do
            let(:data) { build(:api_v1_filters_results_user_result, :without_partner_number, :with_sold_tos) }

            it { expect { subject }.to(change { data.partners }) }
            it do
              subject
              expect(data.partners.size).to eql(data.object.assigned_partners.size)
            end
          end
        end
      end
    end
  end

  describe '#by_assigned_ship_tos' do
    subject { instance.send(:by_assigned_ship_tos, data) }

    let(:data) { build(:api_v1_filters_results_user_result, :without_partner_number, :with_ship_tos) }

    it { expect { subject }.to(change { data.partners }) }
  end

  describe '#by_assigned_sold_tos' do
    subject { instance.send(:by_assigned_sold_tos, data) }

    let(:data) { build(:api_v1_filters_results_user_result, :without_partner_number, :with_sold_tos) }

    it { expect { subject }.to(change { data.partners }) }
  end

  describe '#customer_admins_can_maintain?' do
    subject { instance.send(:customer_admins_can_maintain?) }

    it { is_expected.to be_truthy }
  end
end
