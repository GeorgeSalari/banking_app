class TransactionsController < ApplicationController
  before_action :authenticate_user
  before_action :validate_from_account, only: :create
  before_action :validate_to_account, only: :create
  before_action :find_from_account, only: :create

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      if @from_bank_account.balance >= @transaction.amount
        @from_bank_account.update(balance: @from_bank_account.balance - @transaction.amount)
        @to_bank_account.update(balance: @to_bank_account.balance + @transaction.amount)
        flash[:success] = "Tranfer completed!"
        redirect_to funds_path
      else
        @transaction.destroy
        flash[:alert] = "Not enough funds, maximum #{@from_bank_account.balance}"
        render new_transaction_path
      end
    else
      flash[:alert] = @transaction.errors.messages.join(',')
      render new_transaction_path
    end
  end

  private

  def transaction_params
    permited_params = params.require(:transaction).permit(:amount, :from_bank_account_id)
    unless BankAccount.pluck(:account).include?(params[:transaction][:to_bank_account])
      flash[:alert] = "Please write a valid bank account!"
      return redirect_to new_transaction_path
    end
    @to_bank_account = BankAccount.find_by(account: params[:transaction][:to_bank_account])
    permited_params.merge({to_bank_account_id: @to_bank_account.id})
  end

  def validate_from_account
    unless transaction_params[:from_bank_account_id].present? ||
           current_user.bank_accounts.pluck(:id).include?(transaction_params[:from_bank_account_id].to_i)
      flash[:alert] = "Please select your bank account!"
      return redirect_to new_transaction_path
    end
  end

  def validate_to_account
    if transaction_params[:from_bank_account_id].to_i == @to_bank_account.id
      flash[:alert] = "You can't transfer to same account"
      return redirect_to new_transaction_path
    end
  end

  def find_from_account
    @from_bank_account = BankAccount.find(transaction_params[:from_bank_account_id])
  end
end
