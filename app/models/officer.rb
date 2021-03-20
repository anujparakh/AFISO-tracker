class Officer < ApplicationRecord
    has_many :payments
    has_many :transactions
    validates_uniqueness_of :email
end
