class CreateOrderGoods < ActiveRecord::Migration
  def change
    create_table :order_goods do |t|
      t.references :order
      t.references :good
      t.text :variant
      t.integer :count
      t.decimal :price, :precision => 8, :scale => 3

      t.timestamps
    end

    add_index :order_goods, :order_id
    add_index :order_goods, :good_id
  end
end
