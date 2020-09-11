class ChangeStatusTypeToCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :status, :integer
  end
end
