class AddPosition < ActiveRecord::Migration
  def up
    add_column :locations, :position, :integer, default: 0
    add_column :rack_mounts, :position, :integer, default: 0
    add_column :servers, :position, :integer, default: 0
    add_column :vms, :position, :integer, default: 0
  end

  def down
    remove_column :locations, :position
    remove_column :rack_mounts, :position
    remove_column :servers, :position
    remove_column :vms, :position
  end
end
