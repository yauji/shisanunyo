class AddUnfixIssueToTradeLog < ActiveRecord::Migration
  def change
    add_column :trade_logs, :base_issue_id, :integer
    add_index :trade_logs, :base_issue_id
  end
end
