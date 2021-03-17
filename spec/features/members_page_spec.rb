require "rails_helper"

RSpec.describe "Members Page", type: :feature do

  # MUST test each page to make sure it's password protected
  describe "Password Protected" do
    it "shows the password page" do
      visit members_path
      expect(page).to have_content("password")
    end

    it "logs in with a wrong password and fails" do
      visit members_path

      # Fill in password
      fill_in "code word", with: "wrong"
      click_button("Go")

      expect(page).to have_content("Try again")
    end
  end

  # Check to make sure each page works
  describe "Index Page" do
    it "logs in and shows the members index page" do
      visit members_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Members")
    end
	
	it "can change view to members active in a certain semester" do
	  # login and create semester/member to test with
	  Semester.new(semester_name: 'Spring 2021', start_date: DateTime.now, end_date: DateTime.now + 3, dues_deadline: DateTime.now + 1).save
	  Member.new(name: "John Doe", email: "johndoe@deleter.com").save
	  visit members_path
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

	  # test view change	  
	  select('Spring 2021', :from=>'view_semester_id') 
	  visit members_path(Semester.last.id)
	  expect(page).to_not have_content("John Doe")
	end
	
	it "displays a generated mailing list from the current view" do
	  # login and create members to test with
	  Member.new(name: "Jane Doe", email: "janedoe@deleter.com").save
	  Member.new(name: "Jane Doe", email: "janedoe@deleter.com").save
	  visit members_path
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")
	  
	  # see if list is displayed on page (make list visible)
	  click_button("Show/Hide List") # TODO - fix not unhiding list
	  expect(page).to have_content("janedoe@deleter.com,johndoe@deleter.com")
	end
  end

  describe "Create Page" do
    it "logs in and visits the page" do
      visit new_member_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("New Member")
    end

    it "tries to create a new valid member" do
      visit new_member_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "name", with: "John Doe"
      fill_in "email", with: "johndoe@gmail.com"
      click_button("Add Member")
      expect(page).to_not have_content("Invalid")
    end

    it "tries to create a new invalid member" do
      visit new_member_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "name", with: "Bad Doe"
      fill_in "email", with: "fakeemail" #invalid email
      click_button("Add Member")
      expect(page).to have_content("Invalid")
    end
  end

  describe "Edit Member" do
    it "opens edit page for a member" do
	  Member.new(name: "Jane Doe", email: "janedoe@deleter.com").save
      visit edit_member_path(Member.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Updating")
    end

    it "opens edit page for a semester and changes the name" do
	  Member.new(name: "Jane Doe", email: "janedoe@deleter.com").save
      visit edit_member_path(Member.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "name", with: "New Person"
      click_button("Update Member")

      expect(page).to have_content("New Person")
    end

    it "opens edit page for a member and changes to an invalid email" do
	  Member.new(name: "Jane Doe", email: "janedoe@deleter.com").save
      visit edit_member_path(Member.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "email", with: "wrongemail.com"
      click_button("Update Member")

      expect(page).to have_content("Invalid")
    end
  end

  describe "Show Member" do
    it "opens show page for a member" do
	  Member.new(name: "Jane Doe", email: "janedoe@deleter.com").save
      visit member_path(Member.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Member")
    end
  end

  describe "Delete Member" do
    it "opens delete page for a member" do
	  Member.new(name: "Jane Doe", email: "janedoe@deleter.com").save
      visit delete_member_path(Member.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Delete")
    end

    it "Deletes a Member" do
      Member.new(name: "Jane Doe", email: "janedoe@deleter.com").save
      visit delete_member_path(Member.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      click_button("Delete Member")
      expect(page).to have_content("Member deleted")
    end
  end  
end
