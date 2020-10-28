require 'rails_helper'

RSpec.describe ConsultantsHelper, type: :helper do
  describe 'consultants_for_select' do
    let(:expected) do
      Consultant.pluck(:id, :name).map do |id, name|
        ["#{name}", id]
      end
    end

    before { create_list(:consultant, 3) }

    it do
      expect(consultants_for_select).to eq(expected)
    end
  end
end
