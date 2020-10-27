require 'rails_helper'

RSpec.describe TreatmentsController, type: :controller do
  let(:treatment) { create(:treatment) }
  let(:valid_params) { { id: treatment, treatment: treatment.attributes } }
  let(:permitted_params) { %i[treatment_type status rate description budget customer_id consultant_id title] }
  let(:customer) { create(:customer) }
  let(:consultant) { create(:consultant) }

  describe 'GET #index' do
    let!(:treatments) { create_list(:treatment, 2) }

    before { get :index }

    it { expect(response).to render_template(:index) }
    it { expect(assigns[:treatments]).to match_array(treatments) }
  end

  describe 'GET #new' do
    before { get :new }

    it { expect(response).to render_template(:new) }
    it { expect(assigns[:treatment]).to be_a_new(Treatment) }
  end

  describe 'GET #edit' do
    context 'valid params' do
      before { get :edit, params: { id: treatment } }

      it { expect(response).to render_template(:edit) }
      it { expect(assigns[:treatment]).to eq(treatment) }
    end

    context 'invalid params' do
      before { get :edit, params: { id: 0 } }

      it { expect(response).to redirect_to(treatments_path) }
    end
  end

  describe 'GET #show' do
    context 'valid params' do
      before do
        treatment
        get :show, params: { id: treatment }
      end

      it { expect(assigns[:treatment]).to eq(treatment) }
      it { expect(response).to render_template(:show) }
    end

    context 'invalid params' do
      before { get :show, params: { id: 0 } }

      it { expect(response).to redirect_to(treatments_path) }
    end
  end

  describe 'POST #create' do
    context 'valid params' do
      let(:treatment) { build(:treatment, customer: customer, consultant: consultant) }

      it do
        is_expected.to permit(*permitted_params)
          .for(:create, params: valid_params).on(:treatment)
      end

      it do
        expect do
          post :create, params: valid_params
        end.to change(Treatment, :count).by(1)
      end

      context 'redirect and flash' do
        before { post :create, params: valid_params }

        it { expect(response).to redirect_to(treatment_path(assigns[:treatment])) }
        it { expect(controller).to set_flash[:success] }
      end
    end

    context 'invalid params' do
      let(:invalid_treatment) { build(:treatment, :invalid) }
      let(:invalid_params) { { treatment: invalid_treatment.attributes } }

      before { post :create, params: invalid_params }

      it { expect(response).to render_template(:new) }
      it { expect(controller).to set_flash[:error] }
    end
  end

  describe 'PATCH #update' do
    context 'valid params' do
      let(:updated_description) { 'A updated description. Please describe the treatment.' }

      before do
        treatment
        patch :update, params: { id: treatment, treatment: { description: updated_description } }
      end

      it do
        is_expected.to permit(*permitted_params)
          .for(:update, params: valid_params).on(:treatment)
      end

      it do
        treatment.reload
        expect(treatment.description).to eq(updated_description)
      end

      it { expect(response).to redirect_to(treatment_path(assigns[:treatment]))}
      it { expect(controller).to set_flash[:success] }
    end

    context 'invalid params' do
      before do
        treatment
        patch :update, params: { id: treatment, treatment: { description: "" } }
      end

      it { expect(response).to render_template(:edit) }
      it { expect(controller).to set_flash[:error] }
    end
  end

  describe 'DELETE #destroy' do
    context 'valid id' do
      before { treatment }

      context 'redirect and flash' do
        before do
          delete :destroy, params: { id: treatment }
        end

        it { expect(response).to redirect_to(treatments_path) }
        it { expect(controller).to set_flash[:success] }
      end

      it do
        expect do
          delete :destroy, params: { id: treatment.id }
        end.to change(Treatment, :count).by(-1)
      end
    end

    context 'invalid id' do
      before { delete :destroy, params: { id: 0 } }

      it { expect(response).to redirect_to(treatments_path) }
      it { expect(controller).to set_flash[:error] }
    end
  end
end
