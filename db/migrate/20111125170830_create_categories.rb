class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description

      t.references :parent
      t.integer :position
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.string :link
      t.boolean :visible
      t.boolean :virtual

      t.string :seo_title
      t.string :seo_keywords
      t.string :seo_description

      t.text :parameters

      t.timestamps
    end
    add_index :categories, :parent_id
  end
end
