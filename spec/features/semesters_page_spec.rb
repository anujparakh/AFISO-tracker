# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Semesters Page', type: :feature do
  before(:each) do
    @admin = Admin.create(email: 'test@test.com')
    sign_in @admin
  end

  # MUST test each page to make sure it's password protected
  describe 'Password Protected' do
    it 'shows the password page' do
      visit 'home/index'
      click_on 'Log Out'
      expect(page).to have_content('Sign in with Google')
    end
  end

  # Check to make sure each page works
  describe 'Index Page' do
    it 'logs in and shows the members index page' do
      visit semesters_path
      expect(page).to have_content('Semesters')
    end
  end

  describe 'Create Page' do
    it 'logs in and visits the page' do
      visit new_semester_path
      expect(page).to have_content('New Semester')
    end

    it 'tries to create a new valid semester' do
      visit new_semester_path

      fill_in 'name', with: 'Fall 2021'
      page.find('#semester_start_date_2i').set('January')
      page.find('#semester_start_date_1i').set('1')
      page.find('#semester_start_date_3i').set('1')

      page.find('#semester_end_date_2i').set('January')
      page.find('#semester_end_date_1i').set('2')
      page.find('#semester_end_date_3i').set('2')

      click_button('Add Semester')
      expect(page).to have_content('Semesters')
    end

    it 'tries to create a new invalid semester' do
      visit new_semester_path

      click_button('Add Semester')
      expect(page).to have_content('Invalid')
    end
  end

  describe 'Edit Semester' do
    it 'opens edit page for a semester' do
      visit edit_semester_path(Semester.last.id)
      expect(page).to have_content('Updating')
    end

    it 'opens edit page for a semester and changes the name' do
      visit edit_semester_path(Semester.last.id)

      fill_in 'name', with: 'Spring 2030'
      click_button('Update Semester')

      expect(page).to have_content('Spring 2030')
    end

    it 'opens edit page for a semester and changes the name to something invalid' do
      visit edit_semester_path(Semester.last.id)

      fill_in 'name', with: ''
      click_button('Update Semester')
      expect(page).to have_content('Invalid')
    end
  end

  describe 'Show Semester' do
    it 'opens show page for a semester' do
      visit semester_path(Semester.last.id)
      expect(page).to have_content('Semester')
    end
  end

  describe 'Delete Semester' do
    it 'opens delete page for a semester' do
      visit delete_semester_path(Semester.last.id)
      expect(page).to have_content('Delete')
    end

    it 'Deletes a semester' do
      Semester.new(semester_name: 'Spring 3030', start_date: DateTime.now, end_date: DateTime.now + 3,
                   dues_deadline: DateTime.now + 1).save
      visit delete_semester_path(Semester.last.id)
      click_button('Delete Semester')
      expect(page).to have_content('Semester deleted')
    end
  end
end
