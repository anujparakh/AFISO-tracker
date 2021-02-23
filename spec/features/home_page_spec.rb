require 'rails_helper'

RSpec.describe 'Home Page', type: :feature do

    # MUST test each page to make sure it's password protected
    describe 'Password Protected' do
        it 'shows the password page' do
            visit 'home/index'
            expect(page).to have_content('password')
        end

        it 'logs in with a wrong password and fails' do
            visit 'home/index'

            # Fill in password
            fill_in "code word", with: "wrong"
            click_button('Go')

            expect(page).to have_content('Try again')
       end
    end

    describe 'Index' do
        it 'logs in and shows the welcome page' do
            visit 'home/index'

            # Fill in password
            fill_in "code word", with: ENV['LOCKUP_CODEWORD']
            click_button('Go')

            expect(page).to have_content('Welcome')
        end
    end

    describe 'Help' do
        it 'logs in and shows the help page' do
            visit 'home/help'

            # Fill in password
            fill_in "code word", with: ENV['LOCKUP_CODEWORD']
            click_button('Go')

            expect(page).to have_content('Help')
        end
    end

    describe 'Security' do
        it 'logs in and shows the security page' do
            visit 'home/security'

            # Fill in password
            fill_in "code word", with: ENV['LOCKUP_CODEWORD']
            click_button('Go')

            expect(page).to have_content('Security')
        end
    end
end