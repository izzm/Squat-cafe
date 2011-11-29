class AddUrlPathToCategoryAndStaticPage < ActiveRecord::Migration
  def change
    add_column :categories, :url_path, :string, :limit => 2000
    add_column :static_pages, :url_path, :string, :limit => 2000

    add_index :categories, :url_path
    add_index :static_pages, :url_path
  end
end
