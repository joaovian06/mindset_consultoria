module CustomerHelper
  def customers_for_select
    Customer.pluck(:id, :corporate_name).map do |id, corporate_name|
      ["#{corporate_name}", id]
    end
  end
end
