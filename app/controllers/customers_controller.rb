class CustomersController < ApplicationController
  before_action :find_customer_by_id, only: %i[show edit update destroy]
  before_action :redirect_index_missing_customer, only: %i[show edit]

  def index
    @customers = Customer.all
  end

  def show; end

  def edit; end

  def new
    @customer = Customer.new
  end

  def update
    if @customer.update(customers_params)
      redirect_to_show
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
      render(:edit)
    end
  end

  def create
    @customer = Customer.new(customers_params)
    if @customer.save
      redirect_to(@customer)
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
      render(:new)
    end
  end

  def destroy
    if @customer.present?
      @customer.destroy
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
    end
    redirect_to_index
  end

  private

  def redirect_to_show
    redirect_to(@customer)
  end

  def redirect_to_index
    redirect_to(customers_path)
  end

  def customers_params
    params.require(:customer).permit(:cnpj, :status, :agreement, :phone_number, :corporate_name)
  end

  def redirect_index_missing_customer
    redirect_to_index unless @customer.present?
  end

  def find_customer_by_id
    @customer = Customer.find_by(id: params[:id])
  end
end
