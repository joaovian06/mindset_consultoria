require 'rails_helper'

RSpec.describe Consultant, type: :model do
  describe 'validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:cpf) }
      it { is_expected.to validate_presence_of(:level) }
      it { is_expected.to validate_presence_of(:phone_number) }
      it { is_expected.to validate_presence_of(:name) }
    end

    describe 'length' do
      it { is_expected.to validate_length_of(:name).is_at_least(15).on(:create) }
    end

    describe 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:cpf) }
    end

    describe 'allow values' do
      it { is_expected.to_not allow_value('0001-61').for(:cpf) }
    end
  end

  describe 'enum' do
    it { is_expected.to define_enum_for(:level).with_values(%i[primary secondary]) }
  end

  describe 'factory' do
    it { expect(build(:consultant)).to be_valid }
    it { expect(build(:consultant, :invalid)).to be_invalid }
  end

  describe 'callbacks' do
    describe '#before_validation' do
      context 'set registration_num' do
        let(:time_now) { Time.now }
        let(:consultant) { create(:consultant) }

        before do
          allow(Time).to receive(:now).and_return(time_now)
          consultant.validate
        end

        it { expect(consultant.registration_num).to eq("#{time_now.to_f}") }
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:treatments).inverse_of(:consultant).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for(:treatments).allow_destroy(true) }
  end
end
