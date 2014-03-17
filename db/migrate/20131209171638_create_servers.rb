class CreateServers < ActiveRecord::Migration
  def up
    create_table :servers do |t|
      t.string :name
      t.string :domain
      t.string :model
      t.integer :ram
      t.integer :hd

      t.timestamps
    end
  end

  def down
    drop_table :servers
  end
end
