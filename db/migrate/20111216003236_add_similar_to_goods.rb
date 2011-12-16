class AddSimilarToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :similar, :text
  end
end
