class ConvertDateToBaseIssues < ActiveRecord::Migration
  def up
  end

  def change
    remove_column :base_issues, :date
    remove_column :base_issues, :endDate
    remove_column :trade_logs, :date
    remove_column :account_trans, :date
    add_column :base_issues, :date, :date
    add_column :base_issues, :endDate, :date
    add_column :trade_logs, :date, :date
    add_column :account_trans, :date, :date
  end

  def down
  end
end
