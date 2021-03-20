class Officer < ApplicationRecord
    has_many :payments
    validates_uniqueness_of :email
end
