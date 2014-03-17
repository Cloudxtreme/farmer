class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string :name
      t.string :color

      t.timestamps
    end

    add_column :servers, :category_id, :string
  end

  def down
    drop_table :categories

    remove_column :servers, :category_id
  end
end
