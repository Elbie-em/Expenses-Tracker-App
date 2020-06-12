# rubocop:disable Style/GlobalVars
# rubocop:disable Layout/LineLength:
require 'rails_helper'

RSpec.describe 'Group Management:', type: :feature do
  before :each do
    $user = User.create!(name: 'example', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    $group = $user.groups.create!(name: 'test group', icon: 'https://testicons.com/testicon.png')
  end

  it 'is creating a group with valid input' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit new_group_path
    fill_in 'Name', with: 'test group'
    page.choose('group_icon_httpsdesightprouploadimglinerixtravel-577444168bab7-bigpng')
    click_on 'Save'
    visit groups_path
    expect(page).to have_content('test group')
  end

  it 'is creating a group with invalid input' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit new_group_path
    fill_in 'Name', with: ' '
    page.choose('group_icon_httpsdesightprouploadimglinerixtravel-577444168bab7-bigpng')
    click_on 'Save'
    expect(page).to have_content("Name can't be blank")
  end

  it 'is creating a group with invalid input' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit new_group_path
    fill_in 'Name', with: 'test group'
    click_on 'Save'
    expect(page).to have_content("Icon can't be blank")
  end

  it 'is updating a group with valid input' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit edit_group_path($group)
    fill_in 'Name', with: 'group test'
    click_on 'Save'
    visit groups_path
    expect(page).to have_content('group test')
  end

  it 'is deleting a group' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit edit_group_path($group)
    click_on 'Delete'
    visit groups_path
    expect(page).to_not have_content('test group')
  end
end

# rubocop:enable Style/GlobalVars
# rubocop:enable Layout/LineLength:
