class ChangeEventPriceType < ActiveRecord::Migration
  def change
    remove_column :events, :price
    add_column :events, :price, :string
  end
end
