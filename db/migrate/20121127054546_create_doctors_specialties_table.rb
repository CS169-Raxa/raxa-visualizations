class CreateDoctorsSpecialtiesTable < ActiveRecord::Migration
  def self.up
    create_table :doctors_specialties, :id => false do |t|
        t.references :doctor
        t.references :specialty
    end
    add_index :doctors_specialties, [:doctor_id, :specialty_id]
    add_index :doctors_specialties, [:specialty_id, :doctor_id]
  end

  def self.down
    drop_table :doctors_specialties
  end
end
