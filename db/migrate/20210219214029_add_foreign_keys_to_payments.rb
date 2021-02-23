class AddForeignKeysToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :member_id, :bigint
    add_column :payments, :officer_id, :bigint
    add_column :payments, :semester_id, :bigint
  end
end
