class ChangeRamHd < ActiveRecord::Migration

  def up
    add_column :vms, :ram, :string, default: '0'
    add_column :vms, :hd,  :string, default: '0'

    change_column :servers, :ram, :string, default: '0'
    change_column :servers, :hd, :string, default: '0'
  end

  def down
    remove_column :vms, :ram
    remove_column :vms, :hd
  end

end
