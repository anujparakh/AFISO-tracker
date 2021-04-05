# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :payments, dependent: :destroy
  validates_presence_of :name, :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.get_active_in_semester(s_id)
    # look at payments for given semester
    @payments = Payment.where(semester_id: s_id)
    m_ids = []
    @payments.each_with_index do |payment, _index|
      m_ids.push(payment.member_id)
    end
    # grab members who made payments in given semester
    @members = []
    m_ids.each_with_index do |id, _index|
      @members.push(Member.find(id))
    end
    @members
  end

  def self.member_active_in_semesters(m_id)
    # look at payments for given semester
    @payments = Payment.where(member_id: m_id)
    @sem_ids = []
    @payments.each_with_index do |payment, _index|
      @sem_ids.push(Semester.find(payment.semester_id))
    end
    # get all payments for member
    @active_semester_list = ''
    # iterate through the list
    @sem_ids.each_with_index do |semester, index|
      @active_semester_list += if index == @sem_ids.size - 1
                                 semester.semester_name
                               else
                                 "#{semester.semester_name}, "
                               end
    end

    return 'None' if @active_semester_list == ''

    @active_semester_list
  end
end

# from a list of members, generate a list of their emails
def generate_mailing_list(members)
  @mailing_list = ''
  members.each_with_index do |member, index|
    @mailing_list += member.email
    @mailing_list += ',' if index != members.size - 1
  end
  @mailing_list
end
