class Officer < ApplicationRecord
    has_many :payments, dependent: :destroy
    has_many :transactions, dependent: :destroy
    validates_uniqueness_of :email
end
