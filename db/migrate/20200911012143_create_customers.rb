class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :cnpj
      t.string :status
      t.string :agreement
      t.string :phone_number

      t.timestamps
    end
  end
end
