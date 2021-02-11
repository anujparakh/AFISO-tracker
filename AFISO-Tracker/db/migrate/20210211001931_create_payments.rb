class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.Date :paymentDate
      t.float :paymentAmount

      t.timestamps
    end
  end
end
