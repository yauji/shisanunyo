class ConvertPrincipalJpyToBaseIssues < ActiveRecord::Migration
  def up
  end

  def change
    remove_column :base_issues, :principalJPY
    add_column :base_issues, :principalJPY, :integer
  end

  def down
  end
end
