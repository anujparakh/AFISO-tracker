class Due < ApplicationRecord
  belongs_to :member
  belongs_to :semester_1, :class_name => 'Semester', :foreign_key => 'semester_id_1'
  belongs_to :semester_2, :class_name => 'Semester', :foreign_key => 'semester_id_2', :optional => true
  belongs_to :officer

  validates_presence_of :payment_amount

  def self.filter_on_semester(semester_id)
	# get any Dues that have the matching semester id
    if semester_id == "All"
      return Due.all
    else
      @semester = Semester.find(semester_id)
      return Due.where({ semester_id_1: semester_id }).or(Due.where({ semester_id_2: semester_id }))
    end

  end

  def self.get_total(payment_list)
    # iterate through payments and add each amount to total
    total = 0.0
    payment_list.each_with_index do |payment, index|
      total+=payment.payment_amount
    end
    return total
  end
end
