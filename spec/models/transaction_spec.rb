require 'rails_helper'

RSpec.describe Transaction, :type => :model do
    subject {
        described_class.new(transaction_amount: 100, transaction_date: DateTime.now)
    }

    describe "Validations" do
        it "is not valid without member, officer and semester" do
            expect(subject).to_not be_valid
        end

        it "is not valid without an amount" do
            subject.transaction_amount = nil
            expect(subject).to_not be_valid
        end
    end
end