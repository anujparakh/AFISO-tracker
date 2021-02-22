class Payment < ApplicationRecord
    belongs_to :member
    belongs_to :semester
    belongs_to :officer

    validates_presence_of :paymentAmount, :paymentDate
end
