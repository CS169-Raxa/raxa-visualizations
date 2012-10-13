class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.string :name
      t.float :quantity
      t.float :estimated_rate
      t.float :user_rate
      t.float :alert_level

      t.timestamps
    end
  end
end
