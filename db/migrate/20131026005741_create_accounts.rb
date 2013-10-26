class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :currency
      t.float :balance
      t.float :exchangeRate

      t.timestamps
    end
  end
end
