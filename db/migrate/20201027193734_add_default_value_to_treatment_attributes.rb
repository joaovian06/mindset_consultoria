class AddDefaultValueToTreatmentAttributes < ActiveRecord::Migration[5.2]
  def change
    change_column :treatments, :status, :integer, default: 0
  end
end
