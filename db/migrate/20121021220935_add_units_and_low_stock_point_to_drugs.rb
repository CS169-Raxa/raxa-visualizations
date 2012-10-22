class AddUnitsAndLowStockPointToDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :units, :string
    add_column :drugs, :low_stock_point, :integer
  end
end
