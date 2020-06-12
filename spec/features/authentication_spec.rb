# rubocop:disable Metrics/BlockLength:
require 'rails_helper'

RSpec.describe 'Authentication Management', type: :feature do
  context 'Signing Up:' do
    it 'signs me up and sign me in with valid input' do
      visit new_user_registration_path
      fill_in 'Name', with: 'example'
      fill_in 'Email', with: 'email@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
      visit home_index_path
      expect(page).to have_content('example')
    end

    it 'does not sign me up/sign me in with invalid input(no email)' do
      visit new_user_registration_path
      fill_in 'Name', with: 'example'
      fill_in 'Email', with: ''
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
      expect(page).to have_content("Email can't be blank")
    end

    it 'does not sign me up/sign me in with invalid input(no name)' do
      visit new_user_registration_path
      fill_in 'Name', with: ''
      fill_in 'Email', with: 'email@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
      expect(page).to have_content("Name can't be blank")
    end

    it 'does not sign me up/sign me in with invalid input' do
      visit new_user_registration_path
      fill_in 'Name', with: 'example'
      fill_in 'Email', with: 'email@example.com'
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
      click_button 'Sign up'
      expect(page).to have_content("Password can't be blank")
    end
  end

  context 'Signing in:' do
    before :each do
      User.create!(name: 'example', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    end

    it ':signs me in with valid input' do
      visit new_user_session_path
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
      visit home_index_path
      expect(page).to have_content('example')
    end

    it ':no sign in with invalid input' do
      visit new_user_session_path
      fill_in 'Email', with: ' '
      fill_in 'Password', with: 'password'
      click_on 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    it ':no sign in with invalid input' do
      visit new_user_session_path
      fill_in 'Email', with: 'example@email.com'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end
  end
end

# rubocop:enable Metrics/BlockLength:
