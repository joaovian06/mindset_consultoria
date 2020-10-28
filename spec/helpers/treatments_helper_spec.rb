require 'rails_helper'

RSpec.describe TreatmentsHelper, type: :helper do
  describe 'treatment types for select' do
    it do
      expect(treatment_types_for_select).
        to eq(Treatment.treatment_types.map do
          |k, v| [Treatment.human_attribute_name("treatment_type.#{k}"), k]
        end)
    end
  end
end
