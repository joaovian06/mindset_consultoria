module ConsultantsHelper
  def consultants_for_select
    Consultant.pluck(:id, :name).map do |id, name|
      ["#{name}", id]
    end
  end
end
