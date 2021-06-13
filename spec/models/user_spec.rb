# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  ## Test of validations
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation }

  it 'should give error if password_confirmation not match' do
    user = User.new(email: 'test#gmail.com', password: 'test', password_confirmation: 'not_match')
    user.save
    expect(user.errors.messages[:password_confirmation]).to include("doesn't match Password")
  end
end
