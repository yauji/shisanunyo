class CreateBaseIssues < ActiveRecord::Migration
  def change
    create_table :base_issues do |t|
      t.string :baseCurrency
      t.string :principalJPY
      t.float :principalForeign
      t.string :status
      t.string :name
      t.datetime :date
      t.datetime :endDate
      t.integer :valueJPY
      t.float :valueForeign
      t.float :exchangeRate
      t.float :interestRate
      t.integer :duration
      t.integer :noItem

      t.timestamps
    end
  end
end
