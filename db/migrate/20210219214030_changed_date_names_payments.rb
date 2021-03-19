class ChangedDateNamesPayments < ActiveRecord::Migration[6.1]
  def change
	rename_column :payments, :paymentDate, :payment_date
	rename_column :payments, :paymentAmount, :payment_amount
  end
end
