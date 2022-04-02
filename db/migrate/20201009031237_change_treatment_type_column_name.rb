class ChangeTreatmentTypeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :treatments, :type, :treatment_type
  end
end
