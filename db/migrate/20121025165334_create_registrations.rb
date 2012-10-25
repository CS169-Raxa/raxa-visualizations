class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.timestamp :time_start
      t.timestamp :time_end
      t.string :patient_status

      t.timestamps
    end
  end
end
