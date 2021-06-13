class BankAccount < ApplicationRecord
  validates :account, :user_id, :balance, presence: true
  validates :account, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user
  has_many :from_bank_account, foreign_key: :from_bank_account_id, class_name: "Transaction"
  has_many :to_bank_account, foreign_key: :to_bank_account_id, class_name: "Transaction"
end
