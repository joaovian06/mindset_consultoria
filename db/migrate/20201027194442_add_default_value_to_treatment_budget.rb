class AddDefaultValueToTreatmentBudget < ActiveRecord::Migration[5.2]
  def change
    change_column :treatments, :budget, :integer, default: 0
  end
end
