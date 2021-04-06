class Semester < ApplicationRecord
  has_many :dues, foreign_key: :semester_id_1, dependent: :destroy
  has_many :dues, foreign_key: :semester_id_2, dependent: :destroy
  validates_presence_of :semester_name, :start_date, :end_date
  validates_uniqueness_of :semester_name

  # Makes sure end and due dates are after the start date
  validate :end_date_after_start_date?
  validate :due_date_after_start_date?
  validate :due_date_before_end_date?

  def end_date_after_start_date?
    if end_date != nil and start_date != nil
      if end_date < start_date
        errors.add :end_date, "must be after start date"
      end
    end
  end

  def due_date_after_start_date?
    if dues_deadline != nil and start_date != nil
      if dues_deadline < start_date
        errors.add :dues_deadline, "must be after start date"
      end
    end
  end

  def due_date_before_end_date?
    if dues_deadline != nil and end_date != nil
      if end_date < dues_deadline
        errors.add :dues_deadline, "must be before end date"
      end
    end
  end
end
