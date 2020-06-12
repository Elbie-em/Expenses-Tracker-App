require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.create!(name: 'john doe', email: 'johndoe@example.com', password: 'azerty012') }
  let(:group) { user.groups.create!(name:"test_group",icon:"https://testicons.com/testicon.png")}
  let(:expense) { Expense.create!(name:"test_expense",amount: 24.2,user_id:user.id,group_id: group.id)}

  it 'is valid with valid attributes' do
    expect(expense).to be_valid
  end

  it 'is not valid without a name' do
    expense.name = nil
    expect(expense).to_not be_valid
  end

  it 'is not valid without an amount' do
    expense.amount = nil
    expect(expense).to_not be_valid
  end

  it 'is valid without a group' do
    expense.group_id = nil
    expect(expense).to be_valid
  end

  it 'is not valid without a user' do
    expense.user_id = nil
    expect(expense).to_not be_valid
  end

  describe 'Associations' do
   
    context 'Belonging to existent models' do
      it { should belong_to(:user) }
    end
    

  end

end