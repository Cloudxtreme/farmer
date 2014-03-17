class AddIp < ActiveRecord::Migration
  def up
    add_column :servers, :ip, :string
    add_column :vms, :ip, :string
  end

  def down
    remove_column :servers, :ip
    remove_column :vms, :ip
  end
end
