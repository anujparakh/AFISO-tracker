class Member < ApplicationRecord
  has_many :payments
  validates_presence_of :name, :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.get_active_in_semester(s_id)
    # look at payments for given semester
    @payments = Payment.where(semester_id: s_id)
    m_ids = []
    @payments.each_with_index do |payment, index|
      m_ids.push(payment.member_id)
    end
    # grab members who made payments in given semester
    @members = []
    m_ids.each_with_index do |id, index|
      @members.push(Member.find(id))
    end
    return @members
  end
end

# from a list of members, generate a list of their emails
def generate_mailing_list(members)
  @mailing_list = ""
  members.each_with_index do |member, index|
    @mailing_list += member.email
    if index != members.size - 1
      @mailing_list += ","
    end
  end
  return @mailing_list
end
