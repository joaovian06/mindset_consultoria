module TreatmentsHelper
  def treatment_types_for_select
    Treatment.treatment_types.map do |k, v|
      [Treatment.human_attribute_name("treatment_type.#{k}"), k]
    end
  end
end
