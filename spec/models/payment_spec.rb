require 'rails_helper'

RSpec.describe Payment, :type => :model do
    subject {
        described_class.new(paymentAmount: 100, paymentDate: DateTime.now)
    }

    describe "Validations" do
        it "is not valid without member, officer and semester" do
            expect(subject).to_not be_valid
        end

        it "is not valid without an amount" do
            subject.paymentAmount = nil
            expect(subject).to_not be_valid
        end
    end
end