# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccount, type: :model do

  ## Test of validations
  it { should validate_presence_of :account }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :balance }

  ## Test of associations
  it { should belong_to(:user) }
  it { should have_many(:from_bank_account) }
  it { should have_many(:to_bank_account) }

  it 'validate uniqueness of account' do
    user = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
    bank_account = BankAccount.create(user_id: user.id, account: '1234-1234-1234-1234')
    user_1 = User.create(email: 'test1@gmail.com', password: 'test', password_confirmation: 'test')
    bank_account_1 = BankAccount.create(user_id: user_1.id, account: '1234-1234-1234-1234')
    expect(bank_account_1.errors.messages[:account]).to include('has already been taken')
  end

  it 'validate not have a negative balance' do
    user = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
    bank_account = BankAccount.create(user_id: user.id, account: '1234-1234-1234-1234')
    bank_account.update(balance: -5)
    expect(bank_account.errors.messages[:balance]).to include("must be greater than or equal to 0")
  end
end
