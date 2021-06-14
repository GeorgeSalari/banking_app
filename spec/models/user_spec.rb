# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  ## Test of validations
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation }

  ## Test of associations
  it { should have_many(:bank_accounts).dependent(:destroy) }

  it 'should give error if password_confirmation not match' do
    user = User.create(email: 'test#gmail.com', password: 'test', password_confirmation: 'not_match')
    expect(user.errors.messages[:password_confirmation]).to include("doesn't match Password")
  end

  it 'should create bank_account after create user' do
    user = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
    expect(user.bank_accounts.count).to be(1)
  end
end
