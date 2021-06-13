class User < ApplicationRecord
  has_secure_password

  validates :password, :password_confirmation, :email, presence: true
  validates :email, uniqueness: true

  has_many :bank_accounts, dependent: :destroy

  after_create :create_bank_account

  def create_bank_account
    BankAccount.create(user_id: id, account: uniq_account)
  end

  def uniq_account
    account = rand.to_s[2..17].scan(/.{4}/).join('-')
    while BankAccount.exists?(account: account) do
      account = rand.to_s[2..17].scan(/.{4}/).join('-')
    end
    account
  end
end
