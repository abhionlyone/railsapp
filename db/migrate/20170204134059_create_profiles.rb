class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.text :description
      t.string :linkedin
      t.string :fb
      t.string :twitter

      t.timestamps null: false
    end
  end
end
