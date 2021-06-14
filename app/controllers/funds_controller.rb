class FundsController < ApplicationController
  before_action :authenticate_user

  def index
    @bank_accounts = current_user.bank_accounts
  end
end
