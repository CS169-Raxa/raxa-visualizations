class AddAssociationsToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :patient_id, :integer
    add_column :registrations, :registrar_id, :integer
  end
end
