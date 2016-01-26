class CreateTunes < ActiveRecord::Migration
  def change
    create_table :tunes do |t|
      t.string :url
      t.string :artist
      t.string :title
      t.string :html
      t.integer :score, default: 0
      t.timestamp :order, index: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_reference :comments, :tune, index: true
  end
end
