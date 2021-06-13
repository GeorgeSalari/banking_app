class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :from_bank_account, foreign_key: { to_table: 'bank_accounts' }, index: true
      t.references :to_bank_account, foreign_key: { to_table: 'bank_accounts' }, index: true
      t.string :amount
      t.timestamps
    end
  end
end
