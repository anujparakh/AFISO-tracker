require 'rails_helper'

RSpec.describe Payment, :type => :model do
    subject {
        described_class.new(payment_amount: 100, payment_date: DateTime.now)
    }

    describe "Validations" do
        it "is not valid without member, officer and semester" do
            expect(subject).to_not be_valid
        end

        it "is not valid without an amount" do
            subject.payment_amount = nil
            expect(subject).to_not be_valid
        end
    end

    describe "Test Methods" do
        it "filter on a semester" do
            expect(Payment.filter_on_semester(Semester.last.id).size).to be >= 0
        end

        it "filter on all semesters" do
            expect(Payment.filter_on_semester("All").size).to be >= 0
        end
    end
end