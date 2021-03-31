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

    describe "Transaction Methods" do
        it "try to calculate total" do
            @transaction1 = Transaction.new(transaction_amount: 500, transaction_type: true)
            @transaction2 = Transaction.new(transaction_amount: 500, transaction_type: false)
            expect(Transaction.get_total([@transaction1, @transaction2])).to eq(0)
        end

        it "filter all Semesters and Types" do
            expect(Transaction.filter_on_semester_and_type("All", "All").size).to be >= 0
        end

        it "filter a Semester and all Types" do
            expect(Transaction.filter_on_semester_and_type("All", Semester.last.id).size).to be >= 0
        end

        it "filter all Semesters a Type" do
            expect(Transaction.filter_on_semester_and_type(true, "All").size).to be >= 0
        end

        it "filter a Semester and a Type" do
            expect(Transaction.filter_on_semester_and_type(true, Semester.last.id).size).to be >= 0
        end
    end
end