require "rails_helper"

RSpec.describe "Dues Page", type: :feature do
  before :all do
    Semester.new(semester_name: 'Spring 3030', start_date: DateTime.now, end_date: DateTime.now + 3, dues_deadline: DateTime.now + 1).save
	  Member.new(name: "John Doe", email: "johndoe@deleter.com").save
	  Officer.new(name: "John Doe", email: "johndoe@deleter.com").save
    Due.new(payment_amount: 1010, payment_date: DateTime.now, member_id: Member.last.id, semester_id: Semester.last.id, officer_id: Officer.last.id).save
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
      visit dues_path

      expect(page).to have_content("Dues")
    end
  end

  describe "Create Page" do
    it "logs in and visits the page" do
      visit new_due_path

      expect(page).to have_content("New Dues")
    end

    it "tries to create a new valid dues payment" do
      visit new_due_path

      fill_in "due_payment_amount", with: 50
      select Member.last.email, :from => "due_member_id"
      select Semester.last.semester_name, :from => "due_semester_id"
      select Officer.last.email, :from => "due_officer_id"

      click_button("Add Dues Payment")
      expect(page).to have_content("Dues")
    end

    it "tries to create a new invalid dues payment" do
      visit new_due_path

      click_button("Add Dues Payment")
      expect(page).to have_content("Invalid")
    end

    it "tries to create a new invalid dues payment without payment amount" do
      visit new_due_path

      select Member.last.email, :from => "due_member_id"
      select Semester.last.semester_name, :from => "due_semester_id"
      select Officer.last.email, :from => "due_officer_id"

      click_button("Add Dues Payment")
      expect(page).to have_content("Invalid")
    end
  end

  describe "Edit Due" do
    it "opens edit page for a dues payment" do
      visit edit_due_path(Due.last.id)
      expect(page).to have_content("Update")
    end

    it "opens edit page for a payment and changes the payment amount" do
      visit edit_due_path(Due.last.id)
      fill_in "due_payment_amount", with: 123456
      click_button("Update Dues Payment")

      expect(page).to have_content("123456")
    end

    it "opens edit page for a member and changes to an invalid payment" do
      visit edit_due_path(Due.last.id)
      fill_in "due_payment_amount", with: ""
      click_button("Update Dues Payment")

      expect(page).to have_content("Update")
    end

  end

  describe "Show Due" do
    it "opens show page for a payment" do
      visit due_path(Due.last.id)
      expect(page).to have_content("Payment")
    end
  end

  describe "Delete Due" do
    it "opens delete page for a payment" do
      visit delete_due_path(Due.last.id)
      expect(page).to have_content("Delete")
    end

    it "Deletes a Dues Payment" do
      visit delete_due_path(Due.last.id)
      click_button("Delete Dues Payment")
      expect(page).to have_content("Dues")
    end
  end
end
