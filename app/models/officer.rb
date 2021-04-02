class Officer < ApplicationRecord
    has_many :payments, dependent: :destroy
    has_many :transactions, dependent: :destroy
    validates_uniqueness_of :email
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates_presence_of :email
end
