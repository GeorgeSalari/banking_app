class CreateBankAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_accounts do |t|
      t.string :account, unique: true, null: false, index: true
      t.references :user, null: false, foreign_key: true
      t.float :balance, default: 0, null: false
      t.timestamps
    end
  end
end
