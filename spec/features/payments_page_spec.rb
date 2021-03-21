require "rails_helper"

RSpec.describe "Payments Page", type: :feature do
  before :all do
    Semester.new(semester_name: 'Spring 3030', start_date: DateTime.now, end_date: DateTime.now + 3, dues_deadline: DateTime.now + 1).save
	  Member.new(name: "John Doe", email: "johndoe@deleter.com").save
	  Officer.new(name: "John Doe", email: "johndoe@deleter.com").save
    Payment.new(payment_amount: 1010, payment_date: DateTime.now, member_id: Member.last.id, semester_id: Semester.last.id, officer_id: Officer.last.id).save
  end

  before(:each) do
    @admin = Admin.create(email: "test@test.com")
    sign_in @admin
  end

  # MUST test each page to make sure it's password protected
  describe "Password Protected" do
    it "shows the password page" do
      visit "home/index"
      click_on "Log Out"
      expect(page).to have_content("Sign in with Google")
    end
  end

  # Check to make sure each page works
  describe "Index Page" do
    it "logs in and shows the members index page" do
      visit payments_path

      expect(page).to have_content("Payments")
    end
  end

  describe "Create Page" do
    it "logs in and visits the page" do
      visit new_payment_path

      expect(page).to have_content("New Payment")
    end

    it "tries to create a new valid payment" do
      visit new_payment_path

      fill_in "payment_payment_amount", with: 50
      select Member.last.email, :from => "payment_member_id"
      select Semester.last.semester_name, :from => "payment_semester_id"
      select Officer.last.email, :from => "payment_officer_id"
      click_button("Add Payment")
      expect(page).to have_content("Payments")
    end

    it "tries to create a new invalid payment" do
      visit new_payment_path

      click_button("Add Payment")
      expect(page).to have_content("Invalid")
    end

    it "tries to create a new invalid payment without payment amount" do
      visit new_payment_path

      select Member.last.email, :from => "payment_member_id"
      select Semester.last.semester_name, :from => "payment_semester_id"
      select Officer.last.email, :from => "payment_officer_id"

      click_button("Add Payment")
      expect(page).to have_content("Invalid")
    end
  end

  describe "Edit Payment" do
    it "opens edit page for a payment" do
      visit edit_payment_path(Payment.last.id)
      expect(page).to have_content("Update")
    end

    it "opens edit page for a payment and changes the name" do
      visit edit_payment_path(Payment.last.id)
      fill_in "payment_payment_amount", with: 123456
      click_button("Update Payment")

      expect(page).to have_content("123456")
    end

    it "opens edit page for a member and changes to an invalid payment" do
      visit edit_payment_path(Payment.last.id)
      fill_in "payment_payment_amount", with: ""
      click_button("Update Payment")

      expect(page).to have_content("Update")
    end

  end

  describe "Show Payment" do
    it "opens show page for a payment" do
      visit payment_path(Payment.last.id)
      expect(page).to have_content("Payment")
    end
  end

  describe "Delete Payment" do
    it "opens delete page for a payment" do
      visit delete_payment_path(Payment.last.id)
      expect(page).to have_content("Delete")
    end

    it "Deletes a Payment" do
      visit delete_payment_path(Payment.last.id)
      click_button("Delete payment")
      expect(page).to have_content("Payments")
    end
  end
end
