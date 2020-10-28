class AddPhoneNumberToConsultant < ActiveRecord::Migration[5.2]
  def change
    add_column :consultants, :phone_number, :string
  end
end
