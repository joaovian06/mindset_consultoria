require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'GET #index' do
    let!(:customers) { create_list(:customer, 10) }

    before { get :index }

    it { expect(response).to render_template(:index) }
  end
end
