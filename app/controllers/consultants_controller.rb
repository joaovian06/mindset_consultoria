class ConsultantsController < ApplicationController
  before_action :find_consultant_by_id, only: %i[show edit update destroy]
  before_action :redirect_to_index_missing_consultant, only: %i[show edit]

  def index
    @consultants = Consultant.all
  end

  def show; end

  def edit; end

  def new
    @consultant = Consultant.new
  end

  def create
    @consultant = Consultant.new(permit_params)
    if @consultant.save
      redirect_to_show
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
      render(:new)
    end
  end

  def update
    if @consultant.update(permit_params)
      redirect_to_show
      flash[:success] = t('.success')
    else
      render(:edit)
      flash[:error] = t('.error')
    end
  end

  def destroy
    if @consultant.present?
      @consultant.destroy
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
    end
    redirect_to_index
  end

  private

  def redirect_to_index
    redirect_to(consultants_path)
  end

  def redirect_to_show
    redirect_to(@consultant)
  end

  def permit_params
    params.require(:consultant).permit(:name, :cpf, :level, :phone_number, :registration_num)
  end

  def redirect_to_index_missing_consultant
    redirect_to_index unless @consultant.present?
  end

  def find_consultant_by_id
    @consultant = Consultant.find_by(id: params[:id])
  end
end
