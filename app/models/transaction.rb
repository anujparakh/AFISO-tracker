class Transaction < ApplicationRecord
    belongs_to :officer
    validates_presence_of :transaction_amount
    
    def self.get_specific_type(type_given)
        # grab transactions of specified type
        #type_bool = type_given == "true" ? true : false
        @transactions = Transaction.where(transaction_type: type_given)
        return @transactions
    end
end