class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.string :title
      t.text :content

      t.references :parent
      t.integer :position
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.string :link
      t.boolean :visible

      t.string :seo_title
      t.string :seo_keywords
      t.string :seo_description

      t.timestamps
    end

    add_index :static_pages, :parent_id
  end
end
