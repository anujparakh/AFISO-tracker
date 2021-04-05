# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :member
  belongs_to :semester
  belongs_to :officer

  validates_presence_of :payment_amount

  def self.filter_on_semester(semester_id)
    if semester_id == 'All'
      Payment.all
    else
      @semester = Semester.find(semester_id)
      Payment.where({ semester_id: semester_id })
    end
  end

  def self.get_total(payment_list)
    # iterate through payments and add each amount to total
    total = 0.0
    payment_list.each_with_index do |payment, _index|
      total += payment.payment_amount
    end
    total
  end
end
