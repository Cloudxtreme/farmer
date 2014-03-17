class CreateVms < ActiveRecord::Migration
  def up
    create_table :vms do |t|
      t.string :name
      t.string :domain
      t.string :server_id

      t.timestamps
    end
  end

  def down
    drop_table :vms
  end
end
