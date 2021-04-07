# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :officer
  validates_presence_of :transaction_amount

  # Filters all transactions based on a given semester and type
  def self.filter_on_semester_and_type(type_given, semester_id)
    if type_given == 'All' && semester_id == 'All'
      Transaction.all
    elsif type_given == 'All'
      @semester = Semester.find(semester_id)
      Transaction.where({ transaction_date: @semester.start_date..@semester.end_date })
    elsif semester_id == 'All'
      Transaction.where(transaction_type: type_given)
    else
      @semester = Semester.find(semester_id)
      Transaction.where({ transaction_date: (@semester.start_date)..@semester.end_date,
                          transaction_type: type_given })
    end
  end

  def self.get_total(transaction_list)
    # iterate through transactions and add each amount to total
    total = 0.0
    transaction_list.each_with_index do |transaction, _index|
      if transaction.transaction_type
        total += transaction.transaction_amount
      else
        total -= transaction.transaction_amount
      end
    end
    total
  end
end
