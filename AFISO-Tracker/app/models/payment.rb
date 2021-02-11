class Payment < ApplicationRecord
    belongs_to :member, foreign_key: true
    belongs_to :semester, foreign_key: true
    belongs_to :officer, foreign_key: true
end
