class CreateRegistrars < ActiveRecord::Migration
  def change
    create_table :registrars do |t|
      t.string :name

      t.timestamps
    end
  end
end
