class BankAccount < ApplicationRecord
  validates :account, :user_id, :balance, presence: true
  validates :account, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user
  has_many :from_bank_account, foreign_key: :from_bank_account_id, class_name: "Transaction"
  has_many :to_bank_account, foreign_key: :to_bank_account_id, class_name: "Transaction"

  before_update :check_from_account, if: proc{|acc| acc.user.email != 'admin@bank.accounts'}

  def check_from_account
    admin_account = User.find_by(email: 'admin@bank.accounts').bank_accounts.first
    if !from_bank_account.present? && !to_bank_account.present?
      Transaction.create(amount: balance, from_bank_account_id: admin_account.id, to_bank_account_id: id)
      return true
    end

    last_transaction = Transaction.where('from_bank_account_id = ? OR to_bank_account_id = ?', 5, 5).order(:created_at).last

    if balance > balance_was && (balance - balance_was) != last_transaction.amount
      Transaction.create(amount: balance - balance_was, from_bank_account_id: admin_account.id, to_bank_account_id: id)
      return true
    elsif balance < balance_was && (balance_was - balance) != last_transaction.amount
      Transaction.create(amount: balance_was - balance, from_bank_account_id: id, to_bank_account_id: admin_account.id)
      return true
    end
  end
end
