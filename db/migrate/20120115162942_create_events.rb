class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :short_description
      t.text :description
      t.integer :price

      t.boolean :visible
      t.boolean :featured
      t.timestamp :date

      t.timestamps
    end
  end
end
