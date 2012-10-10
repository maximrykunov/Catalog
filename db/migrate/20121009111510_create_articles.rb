class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.references :category

      t.timestamps
    end
    add_index :articles, :category_id
  end
end
