class CreateConsultants < ActiveRecord::Migration[5.2]
  def change
    create_table :consultants do |t|
      t.string :cpf
      t.integer :level
      t.string :registration_num

      t.timestamps
    end
  end
end
