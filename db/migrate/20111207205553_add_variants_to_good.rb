class AddVariantsToGood < ActiveRecord::Migration
  def change
    add_column :goods, :variants, :text
  end
end
