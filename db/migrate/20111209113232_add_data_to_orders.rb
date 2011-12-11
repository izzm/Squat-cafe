class AddDataToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :number, :string
    add_column :orders, :delivery_type, :string
    add_column :orders, :address, :string
    add_column :orders, :comment, :text
  end
end
