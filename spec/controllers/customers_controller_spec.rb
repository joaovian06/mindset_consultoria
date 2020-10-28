require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:customer) { create(:customer) }
  let(:permitted_params) { %i[cnpj status agreement phone_number corporate_name] }
  let(:valid_params) { { id: customer.id, customer: customer.attributes } }

  describe 'before_actions' do
    it { expect(controller).to use_before_action(:find_customer_by_id) }
    it { expect(controller).to use_before_action(:redirect_index_missing_customer) }
  end

  describe 'GET #index' do
    let!(:customers) { create_list(:customer, 2) }

    before { get :index }

    it { expect(response).to render_template(:index) }
    it { expect(assigns[:customers]).to eq(customers) }
  end

  describe 'GET #show' do
    context 'valid id' do
      before do
        create(:customer)
        get :show, params: { id: customer.id }
      end

      it { expect(response).to render_template(:show) }
      it { expect(assigns[:customer]).to eq(customer) }
    end

    context 'invalid id' do
      before { get :show, params: { id: 0 } }

      it { expect(response).to redirect_to(customers_path) }
    end
  end

  describe 'GET #edit' do
    context 'valid params' do
      before do
        customer
        get :edit, params: { id: customer.id }
      end

      it { expect(response).to render_template(:edit) }
      it { expect(assigns[:customer]).to eq(customer) }
    end

    context 'invalid params' do
      before { get :edit, params: { id: 0 } }

      it { expect(response).to redirect_to(customers_path) }
    end
  end

  describe 'GET #new' do
    before { get :new }

    it { expect(assigns[:customer]).to be_a_new(Customer) }
    it { expect(response).to render_template(:new) }
  end

  describe 'POST #create' do
    context 'valid params' do
      let(:customer) { build(:customer) }

      it { is_expected.to permit(*permitted_params).for(:create, params: valid_params).on(:customer) }
      it { expect { post :create, params: valid_params }.to change(Customer, :count).by(1) }

      context 'redirects and flash' do
        before { post :create, params: valid_params }

        it { expect(response).to redirect_to(customer_path(assigns[:customer])) }
        it { expect(controller).to set_flash[:success] }
      end
    end

    context 'invalid params' do
      let(:invalid_customer) { build(:customer, :invalid) }
      let(:invalid_params) { { customer: customer.attributes } }

      before { post :create, params: invalid_params }

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to render_template(:new) }
    end
  end

  describe 'PATCH #update' do
    context 'valid params' do
      let(:updated_agreement) { "My updated agreement" }

      before do
        customer
        patch :update, params: { id: customer.id, customer: { agreement: updated_agreement } }
      end

      it { is_expected.to permit(*permitted_params).for(:update, params: valid_params).on(:customer) }

      it do
        customer.reload
        expect(customer.agreement).to eq(updated_agreement)
      end

      it { expect(response).to redirect_to(customer_path) }
      it { expect(controller).to set_flash[:success] }
    end

    context 'invalid params' do
      before do
        customer
        patch :update, params: { id: customer.id, customer: { cnpj: "" } }
      end

      it { expect(controller).to set_flash[:error] }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe 'DELETE #destroy' do
    context 'valid id' do
      context 'set flash and redirect' do
        before { delete :destroy, params: { id: customer.id } }

        it { expect(controller).to set_flash[:success] }
        it { expect(response).to redirect_to(customers_path) }
      end

      context 'delete' do
        before { customer }

        it do
          expect do
            delete :destroy, params: { id: customer.id }
          end.to change(Customer, :count).by(-1)
        end
      end
    end

    context 'invalid id' do
      before { delete :destroy, params: { id: 0 } }

      it { expect(response).to redirect_to(customers_path) }
      it { expect(controller).to set_flash[:error] }
    end
  end
end
