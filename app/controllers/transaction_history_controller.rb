class TransactionHistoryController < ApplicationController
  before_action :authenticate_user
  before_action :validate_belongs_of_bank_acccount

  def index
    @deposits = @bank_account.to_bank_account
    @witdrawals = @bank_account.from_bank_account
  end

  private

  def validate_belongs_of_bank_acccount
    unless current_user.bank_accounts.pluck(:id).include?(params[:bank_account_id].to_i)
      flash[:alert] = "Please select your bank account!"
      return redirect_to funds_path
    end
    @bank_account = BankAccount.find(params[:bank_account_id])
  end
end
