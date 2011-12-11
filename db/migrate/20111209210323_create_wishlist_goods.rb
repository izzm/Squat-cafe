class CreateWishlistGoods < ActiveRecord::Migration
  def change
    create_table :wishlist_goods do |t|
      t.references :customer
      t.references :good

      t.timestamps
    end
    add_index :wishlist_goods, :customer_id
    add_index :wishlist_goods, :good_id
  end
end
