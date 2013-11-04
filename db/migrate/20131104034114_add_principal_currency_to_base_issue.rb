class AddPrincipalCurrencyToBaseIssue < ActiveRecord::Migration
  def change
    add_column :base_issues, :principalCurrency, :string
  end
end
