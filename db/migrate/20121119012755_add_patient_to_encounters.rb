class AddPatientToEncounters < ActiveRecord::Migration
  def change
    add_column :encounters, :patient_id, :integer
  end
end
