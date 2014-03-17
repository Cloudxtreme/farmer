class CreateRackMounts < ActiveRecord::Migration
  def up
    create_table :rack_mounts do |t|
      t.string :name

      t.timestamps
    end

    add_column :servers, :rack_mount_id, :string
  end

  def down
    remove_column :servers, :rack_mount_id

    drop_table :rack_mounts
  end
end
