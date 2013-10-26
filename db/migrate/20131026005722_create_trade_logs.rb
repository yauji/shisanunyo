class CreateTradeLogs < ActiveRecord::Migration
  def change
    create_table :trade_logs do |t|
      t.datetime :date
      t.string :type
      t.integer :basicPrice
      t.integer :noItem
      t.integer :buyValueJPY
      t.float :buyValueForeign
      t.integer :sellValueJPY
      t.float :sellValueForeign
      t.integer :dividendValueJPY
      t.float :dividendValueForeign

      t.timestamps
    end
  end
end
