class AddMemoToIssueAndTradelogAndAccount < ActiveRecord::Migration
  def change
    add_column :base_issues, :memo, :text
    add_column :trade_logs, :memo, :text
    add_column :accounts, :memo, :text

  end
end
