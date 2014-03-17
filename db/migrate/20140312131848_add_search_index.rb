class AddSearchIndex < ActiveRecord::Migration

  def up
    add_column :locations, :search_index, :text, default: ''
    add_column :rack_mounts, :search_index, :text, default: ''
    add_column :servers, :search_index, :text, default: ''
    add_column :vms, :search_index, :text, default: ''
  end

  def down
    remove_column :locations, :search_index
    remove_column :rack_mounts, :search_index
    remove_column :servers, :search_index
    remove_column :vms, :search_index
  end

end
