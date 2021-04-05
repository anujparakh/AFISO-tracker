# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Page', type: :feature do
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

  describe 'Index' do
    it 'logs in and shows the welcome page' do
      visit 'home/index'
      # Fill in password
      expect(page).to have_content('Welcome')
    end
  end

  describe 'Help' do
    it 'logs in and shows the help page' do
      visit 'home/help'
      expect(page).to have_content('Help')
    end
  end

  describe 'Settings' do
    it 'logs in and shows the settings page' do
      visit 'home/settings'
      expect(page).to have_content('Settings')
    end
  end
end
