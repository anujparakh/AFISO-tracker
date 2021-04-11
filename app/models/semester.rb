# frozen_string_literal: true

class Semester < ApplicationRecord
  has_many :dues, foreign_key: :semester_id_1
  has_many :dues, foreign_key: :semester_id_2
  after_destroy :delete_dues
  validates_presence_of :semester_name, :start_date, :end_date
  validates_uniqueness_of :semester_name

  # Makes sure end and due dates are after the start date
  validate :end_date_after_start_date?
  validate :due_date_after_start_date?
  validate :due_date_before_end_date?

  def end_date_after_start_date?
    errors.add :end_date, 'must be after start date' if !end_date.nil? && !start_date.nil? && (end_date < start_date)
  end

  def due_date_after_start_date?
    errors.add :dues_deadline, 'must be after start date' if !dues_deadline.nil? && !start_date.nil? && (dues_deadline < start_date)
  end

  def due_date_before_end_date?
    errors.add :dues_deadline, 'must be before end date' if !dues_deadline.nil? && !end_date.nil? && (end_date < dues_deadline)
  end

  # returns ID of most recent semester
  def self.get_current_semester
    @id = Semester.where('start_date < ?', DateTime.now).order(start_date: :desc).first.id
    if @id == nil
      return Semester.last.id
    else
      return @id
    end
  end

  def delete_dues
    Due.where('semester_id_1 = :id OR semester_id_2 = :id', id: id).map(&:destroy)
  end
end
