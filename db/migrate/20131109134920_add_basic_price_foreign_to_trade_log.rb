class AddBasicPriceForeignToTradeLog < ActiveRecord::Migration
  def change
    add_column :trade_logs, :basicPriceForeign, :float
  end
end
