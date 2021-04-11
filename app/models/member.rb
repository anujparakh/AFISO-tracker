class Member < ApplicationRecord
  has_many :dues, dependent: :destroy
  validates_presence_of :name, :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.get_active_in_semester(s_id)
    # look at payments for given semester
    @payments = Due.where(semester_id_1: s_id).or(Due.where(semester_id_2: s_id))
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

  def self.get_inactive_in_semester(s_id)
    # look at payments for given semester
    @payments = Due.where(semester_id_1: s_id).or(Due.where(semester_id_2: s_id))
    active_ids = []
    @payments.each_with_index do |payment, index|
      active_ids.push(payment.member_id)
    end
    # grab members who made payments in given semester

    @members = []
    @all_members = Member.order('name ASC')
    isactive = false
    @all_members.each_with_index do |member, index|
      isactive = false
      active_ids.each_with_index do |active, index|
        if(member.id == active)
          isactive = true
        end
      end
      if(!isactive)
        @members.push(member)
      end
    end
    

    return @members
  end

  def self.member_active_in_semesters(m_id)
    # look at payments for given semester
    @payments = Due.where(member_id: m_id)
    @sem_ids = []
    @payments.each_with_index do |payment, index|
      @sem_ids.push(Semester.find(payment.semester_id_1))
	  if payment.semester_id_2 != nil
	    @sem_ids.push(Semester.find(payment.semester_id_2))
	  end
    end
    # get all payments for member
    @active_semester_list = ""
    # iterate through the list
    @sem_ids.each_with_index do |semester, index|
      if index == @sem_ids.size - 1
          @active_semester_list += semester.semester_name
      else
          @active_semester_list += semester.semester_name + ", "
      end
    end

    if @active_semester_list == ""
      return "None"
    end

    return @active_semester_list
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
