# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :officer
      t.string :transactionType
      t.datetime :transactionDate
      t.float :transactionAmount

      t.timestamps
    end
  end
end
