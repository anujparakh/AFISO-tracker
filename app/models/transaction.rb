class Transaction < ApplicationRecord
    belongs_to :officer
    validates_presence_of :transaction_amount
end