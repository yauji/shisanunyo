class AddAccountToAccountTran < ActiveRecord::Migration
  def change
    add_column :account_trans, :account_id, :integer, :default => 1
    add_index :account_trans, :account_id
  end
end
