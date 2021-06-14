# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionHistoryController, type: :controller do
  describe 'POST #index' do

    it 'redirects to login path if no user' do
      get :index, params: { bank_account_id: 1 }
      expect(response).to redirect_to('/')
    end

    it "redirects to funds path if account don't belong to user" do
      user = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      user_1 = User.create(email: 'test1@gmail.com', password: 'test', password_confirmation: 'test')
      session[:user_id] = user.id
      get :index, params: { bank_account_id: user_1.bank_accounts.first.id }
      expect(response).to redirect_to('/funds')
    end
  end

end
