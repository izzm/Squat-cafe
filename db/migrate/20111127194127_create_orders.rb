class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :customer

      t.timestamp :delivery_at
      t.timestamp :checked_out_at
      t.boolean :canceled

      t.integer :discount, :default => 0
      t.decimal :total_price, :precision => 8, :scale => 2, :default => 0

      t.timestamps
    end

    add_index :orders, :customer_id
    add_index :orders, :checked_out_at
  end
end
