class Transaction < ApplicationRecord
  validates :from_bank_account, :to_bank_account, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }

  belongs_to :from_bank_account, class_name: "BankAccount"
  belongs_to :to_bank_account, class_name: "BankAccount"
end
