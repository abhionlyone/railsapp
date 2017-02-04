class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.attachment :image

      t.timestamps null: false
    end
  end
end
