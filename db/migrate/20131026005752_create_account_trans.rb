class CreateAccountTrans < ActiveRecord::Migration
  def change
    create_table :account_trans do |t|
      t.datetime :date
      t.float :income
      t.float :expenditure
      t.text :memo

      t.timestamps
    end
  end
end
