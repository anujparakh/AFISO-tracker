require "rails_helper"

RSpec.describe "Semesters Page", type: :feature do

  # MUST test each page to make sure it's password protected
  describe "Password Protected" do
    it "shows the password page" do
      visit semesters_path
      expect(page).to have_content("password")
    end

    it "logs in with a wrong password and fails" do
      visit semesters_path

      # Fill in password
      fill_in "code word", with: "wrong"
      click_button("Go")

      expect(page).to have_content("Try again")
    end
  end

  # Check to make sure each page works
  describe "Index Page" do
    it "logs in and shows the members index page" do
      visit semesters_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Semesters")
    end
  end

  describe "Create Page" do
    it "logs in and visits the page" do
      visit new_semester_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Add Semester")
    end

    it "tries to create a new valid semester" do
      visit new_semester_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "name", with: "Fall 2021"
      page.find("#semester_start_date_2i").set("January")
      page.find("#semester_start_date_1i").set("1")
      page.find("#semester_start_date_3i").set("1")

      page.find("#semester_end_date_2i").set("January")
      page.find("#semester_end_date_1i").set("2")
      page.find("#semester_end_date_3i").set("2")

      click_button("Add Semester")
      expect(page).to have_content("Semesters")
    end

    it "tries to create a new invalid semester" do
      visit new_semester_path

      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      click_button("Add Semester")
      expect(page).to have_content("Add Semester")
    end
  end

  describe "Edit Semester" do
    it "opens edit page for a semester" do
      visit edit_semester_path(Semester.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Update")
    end

    it "opens edit page for a semester and changes the name" do
      visit edit_semester_path(Semester.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "name", with: "Spring 2030"
      click_button("Update Semester")

      expect(page).to have_content("Spring 2030")
    end

    it "opens edit page for a semester and changes the name" do
      visit edit_semester_path(Semester.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      fill_in "name", with: ""
      click_button("Update Semester")

      expect(page).to have_content("Update")
    end
  end

  describe "Show Semester" do
    it "opens show page for a semester" do
      visit semester_path(Semester.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Semester")
    end
  end

  describe "Delete Semester" do
    it "opens delete page for a semester" do
      visit delete_semester_path(Semester.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")

      expect(page).to have_content("Delete")
    end

    it "Deletes a semester" do
      Semester.new(semester_name: 'Spring 3030', start_date: DateTime.now, end_date: DateTime.now + 3, dues_deadline: DateTime.now + 1).save

      visit delete_semester_path(Semester.last.id)
      # Fill in password
      fill_in "code word", with: ENV["LOCKUP_CODEWORD"]
      click_button("Go")
      click_button("Delete Semester")
      expect(page).to have_content("Semester deleted")
    end
  end
end
