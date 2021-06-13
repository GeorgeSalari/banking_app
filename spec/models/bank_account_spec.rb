# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccount, type: :model do

  ## Test of validations
  it { should validate_presence_of :account }
  it { should validate_uniqueness_of :account }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :balance }

  ## Test of associations
  it { should belong_to(:user) }

  it 'validate not have a negative balance' do
    user = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
    bank_account = BankAccount.create(user_id: user.id, account: '1234-1234-1234-1234')
    bank_account.update(balance: -5)
    expect(bank_account.errors.messages).to inlude("Balance can't be less then 0")
  end
end
