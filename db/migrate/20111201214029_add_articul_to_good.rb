class AddArticulToGood < ActiveRecord::Migration
  def change
    add_column :goods, :articul, :string
  end
end
