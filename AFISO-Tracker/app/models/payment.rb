class Payment < ApplicationRecord
    belongs_to :member 
    belongs_to :semester 
    belongs_to :officer 
end
