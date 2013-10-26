class AddTypeToBaseIssue < ActiveRecord::Migration
  def change
    add_column :base_issues, :type, :string
  end
end
