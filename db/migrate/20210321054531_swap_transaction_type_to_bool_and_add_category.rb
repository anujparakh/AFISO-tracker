# frozen_string_literal: true

class SwapTransactionTypeToBoolAndAddCategory < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :transaction_type
    add_column :transactions, :transaction_type, :boolean
    add_column :transactions, :transaction_category, :string
  end
end
