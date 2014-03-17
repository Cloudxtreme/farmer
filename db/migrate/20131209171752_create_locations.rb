class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.string :name

      t.timestamps
    end

    add_column :rack_mounts, :location_id, :string
  end

  def down
    remove_column :rack_mounts, :location_id

    drop_table :locations
  end
end
