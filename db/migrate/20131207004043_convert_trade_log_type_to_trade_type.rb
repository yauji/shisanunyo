class ConvertTradeLogTypeToTradeType < ActiveRecord::Migration
  def up
  end

  def change
    remove_column :trade_logs, :type
    add_column :trade_logs, :tradeType, :string
  end

  def down
  end
end
