class CreateTreatments < ActiveRecord::Migration[5.2]
  def change
    create_table :treatments do |t|
      t.integer :type
      t.integer :status
      t.integer :rate
      t.string :description
      t.integer :budget
      t.references :customer, foreign_key: true
      t.references :consultant, foreign_key: true

      t.timestamps
    end
  end
end
