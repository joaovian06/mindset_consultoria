class AddNameToConsultant < ActiveRecord::Migration[5.2]
  def change
    add_column :consultants, :name, :string
  end
end
