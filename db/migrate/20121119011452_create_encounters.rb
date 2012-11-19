class CreateEncounters < ActiveRecord::Migration
  def change
    create_table :encounters do |t|
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
  end
end
