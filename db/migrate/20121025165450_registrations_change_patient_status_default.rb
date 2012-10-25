class RegistrationsChangePatientStatusDefault < ActiveRecord::Migration
  def up
    change_column_default :registrations, :patient_status, 'new'
  end

  def down
    change_column_default :registrations, :patient_status, nil
  end
end
