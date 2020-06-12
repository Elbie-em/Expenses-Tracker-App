require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { User.create!(name: 'john doe', email: 'johndoe@example.com', password: 'azerty012') }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'is not valid with a name longer than 20 characters' do
    user.name = 'john doe of the lost boys'
    expect(user).to_not be_valid
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).to_not be_valid
  end

  describe 'Associations' do
    context 'Having many from the different existent models' do
      it { should have_many(:groups) }
      it { should have_many(:expenses) }
    end
  end
end