require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create!(name: 'john doe', email: 'johndoe@example.com', password: 'azerty012') }
  let(:group) { user.groups.create!(name: 'test_group', icon: 'https://testicons.com/testicon.png') }

  it 'is valid with valid attributes' do
    expect(group).to be_valid
  end

  it 'is not valid without a name' do
    group.name = nil
    expect(group).to_not be_valid
  end

  it 'is not valid without an icon url' do
    group.icon = nil
    expect(group).to_not be_valid
  end

  describe 'Associations' do
    context 'Having many from the expense model' do
      it { should have_many(:expenses) }
    end

    context 'Belonging to existent model' do
      it { should belong_to(:user) }
    end
  end
end
