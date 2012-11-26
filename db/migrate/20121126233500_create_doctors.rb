class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :specialty
      t.integer :max_workload

      t.timestamps
    end
  end
end
