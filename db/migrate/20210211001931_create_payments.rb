# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.datetime :payment_date
      t.float :paymentAmount

      t.timestamps
    end
  end
end
