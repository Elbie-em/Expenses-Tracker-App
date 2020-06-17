# rubocop:disable Style/GlobalVars
# rubocop:disable Layout/LineLength:

require 'rails_helper'

RSpec.describe 'Expense Management:', type: :feature do
  before :each do
    $user = User.create!(name: 'example', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    $group = $user.groups.create!(name: 'test group', icon: 'https://testicons.com/testicon.png')
    $expense = Expense.create!(name: 'test expense', amount: 24.2, user_id: $user.id, group_id: $group.id)
  end

  it 'is creating a grouped expense with valid input' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit new_expense_path
    fill_in 'Name', with: 'test expense'
    fill_in 'Amount', with: 25
    page.select 'test group', from: 'expense_group_id'
    click_on 'Save'
    visit expenses_path
    expect(page).to have_content('test expense', 'test group')
  end

  it 'is creating an ungrouped expense with valid input' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit new_expense_path
    fill_in 'Name', with: 'test expense'
    fill_in 'Amount', with: 25
    page.select 'None', from: 'expense_group_id'
    click_on 'Save'
    visit home_external_path
    expect(page).to have_content('test expense')
  end

  it 'is creating a grouped expense with invalid input' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit new_expense_path
    fill_in 'Name', with: ''
    fill_in 'Amount', with: ' '
    click_on 'Save'
    expect(page).to have_content("Name can't be blank", "Amount can't be blank")
  end

  it 'is updating a grouped expense with valid input to become an ungrouped expense' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit edit_expense_path($expense)
    fill_in 'Name', with: 'expense test'
    fill_in 'Amount', with: 21
    page.select 'None', from: 'expense_group_id'
    click_on 'Save'
    visit home_external_path
    expect(page).to have_content('expense test')
  end

  it 'is updating a grouped expense with valid input to become an ungrouped expense' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit edit_expense_path($expense)
    click_on 'Delete'
    visit expenses_path
    expect(page).to_not have_content('test expense')
  end
end

# rubocop:enable Style/GlobalVars
# rubocop:enable Layout/LineLength:
