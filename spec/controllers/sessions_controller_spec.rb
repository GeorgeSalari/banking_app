# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do

    it 'redirects to new action when data not valid' do
      post :create, params: { user: { email: '', password: '' } }
      expect(session[:user_id]).to be(nil)
      expect(response).to redirect_to('/login')
    end

    it 'sign in an account with valid data' do
      user = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      params = {
        email: user.email,
        password: user.password
      }
      post :create, params: { user: params }
      expect(session[:user_id]).to be(user.id)
    end
  end

  describe 'POST #destroy' do
    it 'allows user to log out' do
      user = User.create(email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      params = {
        email: user.email,
        password: user.password
      }
      post :create, params: { user: params }
      expect(session[:user_id]).to be(user.id)

      delete :destroy
      expect(session[:user_id]).to be(nil)
      expect(response).to redirect_to('/login')
    end
  end
end
