class RemoveLowStockPointFromDrugs < ActiveRecord::Migration
  def up
    remove_column :drugs, :low_stock_point
  end

  def down
    add_column :drugs, :low_stock_point, :integer
  end
end
