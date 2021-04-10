class ChangedPaymentsToDues < ActiveRecord::Migration[6.1]
  def change
	rename_table :payments, :dues
  end
end
