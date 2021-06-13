# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe 'Get #new' do
    it 'redirects to login if no user' do
      get :new
      expect(response).to redirect_to('/')
    end
  end

  describe 'POST #create' do

    it 'redirects to new action if no amount' do
      user_from = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      session[:user_id] = user_from.id
      post :create, params: {
        transaction: {
          amount: '',
          from_bank_account_id: '',
          to_bank_account: ''
        }
      }
      expect(response).to redirect_to('/transactions/new')
    end

    it 'redirects to new action if no from_bank_account_id' do
      user_from = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      session[:user_id] = user_from.id
      post :create, params: {
        transaction: {
          amount: 10,
          from_bank_account_id: '',
          to_bank_account: ''
        }
      }
      expect(response).to redirect_to('/transactions/new')
    end

    it 'redirects to new action if no to_bank_account_id' do
      user_from = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      session[:user_id] = user_from.id
      from_bank_account = user_from.bank_accounts.first
      post :create, params: {
        transaction: {
          amount: 10,
          from_bank_account_id: from_bank_account.id,
          to_bank_account: ''
        }
      }
      expect(response).to redirect_to('/transactions/new')
    end

    it 'redirects to new action if from user have no balance' do
      user_from = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      session[:user_id] = user_from.id
      from_bank_account = user_from.bank_accounts.first
      to_user = User.create(email: 'test1@gmail.com', password: 'test', password_confirmation: 'test')
      to_bank_account = to_user.bank_accounts.first
      post :create, params: {
        transaction: {
          amount: 10,
          from_bank_account_id: from_bank_account.id,
          to_bank_account: to_bank_account.account,
        }
      }
      expect(response).to redirect_to('/transactions/new')
    end

    it 'redirects to new action if from user have less balance then transfer amount' do
      user_from = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      session[:user_id] = user_from.id
      from_bank_account = user_from.bank_accounts.first
      from_bank_account.update(balance: 5)
      to_user = User.create(email: 'test1@gmail.com', password: 'test', password_confirmation: 'test')
      to_bank_account = to_user.bank_accounts.first
      post :create, params: {
        transaction: {
          amount: 10,
          from_bank_account_id: from_bank_account.id,
          to_bank_account: to_bank_account.account,
        }
      }
      expect(response).to redirect_to('/transactions/new')
    end

    it 'create transaction with valid data and change users balance' do
      user_from = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      session[:user_id] = user_from.id
      from_bank_account = user_from.bank_accounts.first
      from_bank_account.update(balance: 15)
      to_user = User.create(email: 'test1@gmail.com', password: 'test', password_confirmation: 'test')
      to_bank_account = to_user.bank_accounts.first
      post :create, params: {
        transaction: {
          amount: 10,
          from_bank_account_id: from_bank_account.id,
          to_bank_account: to_bank_account.account,
        }
      }
      expect(Transaction.count).to be(1)
      expect(user_from.bank_accounts.first.balance).to be(5.to_f)
      expect(to_user.bank_accounts.first.balance).to be(10.to_f)
    end
  end
end
