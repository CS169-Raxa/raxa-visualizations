class AddDepartmentToEncounters < ActiveRecord::Migration
  def change
    add_column :encounters, :department_id, :integer
  end
end
