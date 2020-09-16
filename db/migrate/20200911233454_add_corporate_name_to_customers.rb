class AddCorporateNameToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :corporate_name, :string
  end
end
