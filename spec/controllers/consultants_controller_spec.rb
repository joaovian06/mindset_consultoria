require 'rails_helper'

RSpec.describe ConsultantsController, type: :controller do
  let(:consultant) { create(:consultant) }
  let(:valid_params) { { id: consultant.id, consultant: consultant.attributes } }
  let(:permitted_params) { [:name, :cpf, :level, :phone_number, :registration_num] }

  describe 'before actions' do
    it { expect(controller).to use_before_action(:find_consultant_by_id) }
    it { expect(controller).to use_before_action(:redirect_to_index_missing_consultant) }
  end

  describe 'GET #index' do
    let!(:consultants) { create_list(:consultant, 3) }

    before { get :index }

    it { expect(response).to render_template(:index) }
    it { expect(assigns[:consultants]).to eq(consultants) }
  end

  describe 'GET #show' do
    context 'valid params' do
      before do
        consultant
        get :show, params: { id: consultant.id }
      end

      it { expect(assigns[:consultant]).to eq(consultant) }
      it { expect(response).to render_template(:show) }
    end

    context 'invalid params' do
      before { get :show, params: { id: 0 } }

      it { expect(response).to redirect_to(consultants_path) }
    end
  end

  describe 'GET #edit' do
    context 'valid params' do
      before do
        consultant
        get :edit, params: { id: consultant.id }
      end

      it { expect(assigns[:consultant]).to eq(consultant) }
      it { expect(response).to render_template(:edit) }
    end

    context 'invalid params' do
      before { get :edit, params: { id: 0 } }

      it { expect(response).to redirect_to(consultants_path) }
    end
  end

  describe 'GET #new' do
    before { get :new }

    it { expect(assigns[:consultant]).to be_a_new(Consultant) }
    it { expect(response).to render_template(:new) }
  end

  describe 'POST #create' do
    context 'valid params' do
      let(:consultant) { build(:consultant) }

      it { is_expected.to permit(*permitted_params).for(:create, params: valid_params).on(:consultant) }

      it do
        expect do
          post :create, params: valid_params
        end.to change(Consultant, :count).by(1)
      end

      context 'redirect and flash' do
        before { post :create, params: valid_params }

        it { expect(response).to redirect_to(consultant_path(assigns[:consultant])) }
        it { expect(controller).to set_flash[:success] }
      end
    end

    context 'invalid params' do
      let(:invalid_consultant) { build(:consultant, :invalid) }
      let(:invalid_params) { { consultant: invalid_consultant.attributes } }

      before { post :create, params: invalid_params }

      it { expect(response).to render_template(:new) }
      it { expect(controller).to set_flash[:error] }
    end
  end

  describe 'PATCH #update' do
    context 'valid params' do
      let(:updated_phone_number) { '(011)99174-1999' }

      before do
        consultant
        patch :update, params: { id: consultant.id, consultant: { phone_number: updated_phone_number } }
      end

      it { is_expected.to permit(*permitted_params).for(:update, params: valid_params).on(:consultant) }

      it do
        consultant.reload
        expect(consultant.phone_number).to eq(updated_phone_number)
      end

      it { expect(response).to redirect_to(consultant_path) }
      it { expect(controller).to set_flash[:success] }
    end

    context 'invalid params' do
      before do
        consultant
        patch :update, params: { id: consultant.id, consultant: { cpf: '' } }
      end

      it { expect(response).to render_template(:edit) }
      it { expect(controller).to set_flash[:error] }
    end
  end

  describe 'DELETE #destroy' do
    context 'valid id' do
      context 'flash and redirect' do
        before { delete :destroy, params: { id: consultant.id } }

        it { expect(controller).to set_flash[:success] }
        it { expect(response).to redirect_to(consultants_path) }
      end

      context 'delete' do
        before { consultant }

        it do
          expect do
            delete :destroy, params: { id: consultant.id }
          end.to change(Consultant, :count).by(-1)
        end
      end
    end

    context 'invalid id' do
      before { delete :destroy, params: { id: 0 } }

      it { expect(response).to redirect_to(consultants_path) }
      it { expect(controller).to set_flash[:error] }
    end
  end
end
