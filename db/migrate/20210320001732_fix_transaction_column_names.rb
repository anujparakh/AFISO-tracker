# frozen_string_literal: true

class FixTransactionColumnNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :transactions, :transactionType, :transaction_type
    rename_column :transactions, :transactionDate, :transaction_date
    rename_column :transactions, :transactionAmount, :transaction_amount
  end
end
