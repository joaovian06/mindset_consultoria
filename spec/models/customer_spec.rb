require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:cnpj) }
      it { is_expected.to validate_presence_of(:status) }
      it { is_expected.to validate_presence_of(:phone_number) }
    end

    describe 'allow values' do
      it { is_expected.not_to allow_value('0001-61').for(:cnpj) }
      it { is_expected.not_to allow_value('99999-000').for(:phone_number) }
    end

    describe 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:cnpj) }
    end
  end

  describe 'enum' do
    it { is_expected.to define_enum_for(:status).with_values(%i[active disable pending]) }
  end
end
