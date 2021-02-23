class Member < ApplicationRecord
    has_many :payments
    validates_presence_of :name, :email
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
