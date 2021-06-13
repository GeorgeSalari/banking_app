class FundsController < ApplicationController
  before_action :authenticate_user

  def index
    @bank_accounts = current_user.bank_accounts
  end

  private

  def authenticate_user
    redirect_to root_path unless current_user.present?
  end
end
