class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name
      t.text :description

      t.references :category
      t.integer :position

      t.integer :price
      t.text :parameters

      t.boolean :visible

      t.timestamps
    end
    add_index :goods, :category_id

    create_table :categories_goods, :id => false do |t|
      t.references :category
      t.references :good
    end
    add_index :categories_goods, [:category_id, :good_id]

  end
end
