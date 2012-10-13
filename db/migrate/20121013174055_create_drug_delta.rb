class CreateDrugDelta < ActiveRecord::Migration
  def change
    create_table :drug_delta do |t|
      t.timestamp :timestamp
      t.float :amount
      t.string :description
      t.belongs_to :drug

      t.timestamps
    end
    add_index :drug_delta, :drug_id
  end
end
