class TreatmentsController < ApplicationController
  before_action :find_treatment_by_id, only: [:edit, :show, :update, :destroy]
  before_action :redirect_index_missing_treatment, only: [:edit, :show]

  def index
    @treatments = Treatment.all
  end

  def new
    @treatment = Treatment.new
  end

  def edit; end

  def show; end

  def create
    @treatment = Treatment.new(permit_params)
    if @treatment.save
      redirect_to_show
      success_flash
    else
      error_flash
      render(:new)
    end
  end

  def update
    if @treatment.update(permit_params)
      redirect_to_show
      success_flash
    else
      error_flash
      render(:edit)
    end
  end

  def destroy
    if @treatment.present?
      @treatment.destroy
      success_flash
    else
      error_flash
    end
    redirect_to_index
  end

  private

  def success_flash
    flash[:success] = t('.success')
  end

  def error_flash
    flash[:error] = t('.error')
  end

  def redirect_to_show
    redirect_to(@treatment)
  end

  def redirect_to_index
    redirect_to(treatments_path)
  end

  def find_treatment_by_id
    @treatment = Treatment.find_by(id: params[:id])
  end

  def redirect_index_missing_treatment
    redirect_to_index unless @treatment.present?
  end

  def permit_params
    params.require(:treatment).permit([:treatment_type, :status, :rate, :description, :budget, :customer_id, :consultant_id])
  end
end
