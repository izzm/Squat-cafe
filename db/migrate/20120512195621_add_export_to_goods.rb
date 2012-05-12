class AddExportToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :export, :boolean
  end
end
