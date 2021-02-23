require "rails_helper"

RSpec.describe "Payments Page", type: :feature do
  before :all do
    Payment.new(paymentAmount: 1010, paymentDate: DateTime.now, member_id: Member.last.id, semester_id: Semester.last.id, officer_id: Officer.last.id).save
  end

  # MUST test each page to make sure it's password protected
  describe "Password Protected" do
    it "shows the password page" do
      visit payments_path
      expect(page).to have_content("password")
    end

    it "logs in with a wrong password and fails" do
      visit payments_path

      # Fill in password
      fill_in "code word", with: "wrong"
      click_button("Go")

      expect(page).to have_content("Try again")
    end
  end

  # Check to make sure each page works
  describe "Index Page" do
    it "logs in and shows the members index page" do
      visit payments_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Payments")
    end
  end

  describe "Create Page" do
    it "logs in and visits the page" do
      visit new_payment_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Create payment")
    end

    it "tries to create a new valid payment" do
      visit new_payment_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "payment_paymentAmount", with: 50
      fill_in "payment_member_id", with: Member.last.id
      fill_in "payment_semester_id", with: Semester.last.id
      fill_in "payment_officer_id", with: Officer.last.id
      click_button("Create payment")
      expect(page).to have_content("Payments")
    end

    it "tries to create a new invalid payment" do
      visit new_payment_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      click_button("Create payment")
      expect(page).to_not have_content("Payments")
    end

    it "tries to create a new invalid payment without payment amount" do
      visit new_payment_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "payment_member_id", with: Member.last.id
      fill_in "payment_semester_id", with: Semester.last.id
      fill_in "payment_officer_id", with: Officer.last.id

      click_button("Create payment")
      expect(page).to_not have_content("Payments")
    end
  end

  describe "Edit Payment" do
    it "opens edit page for a payment" do
      visit edit_payment_path(Payment.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Update")
    end

    it "opens edit page for a payment and changes the name" do
      visit edit_payment_path(Payment.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "payment_paymentAmount", with: 123456
      click_button("Update payment")

      expect(page).to have_content("123456")
    end

    it "opens edit page for a member and changes to an invalid payment" do
      visit edit_payment_path(Payment.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "payment_paymentAmount", with: ""
      click_button("Update payment")

      expect(page).to have_content("Update")
    end

    it "opens edit page for a member and changes to an invalid semester" do
      visit edit_payment_path(Payment.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "payment_semester_id", with: ""
      p "PRINTING"
      click_button("Update payment")

      expect(page).to have_content("Update")
    end
  end

  describe "Show Payment" do
    it "opens show page for a payment" do
      visit payment_path(Payment.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Payment")
    end
  end

  describe "Delete Payment" do
    it "opens delete page for a payment" do
      visit delete_payment_path(Payment.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Delete")
    end

    it "Deletes a Payment" do
      visit delete_payment_path(Payment.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      click_button("Delete payment")
      expect(page).to have_content("Payments")
    end
  end
end
