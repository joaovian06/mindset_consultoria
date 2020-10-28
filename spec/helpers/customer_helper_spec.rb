require 'rails_helper'

RSpec.describe CustomerHelper, type: :helper do
  describe 'customers_for_select' do
    let(:expected) do
      Customer.pluck(:id, :corporate_name).map do |id, corporate_name|
        ["#{corporate_name}", id]
      end
    end

    before { create_list(:customer, 3) }

    it do
      expect(customers_for_select).to eq(expected)
    end
  end
end
