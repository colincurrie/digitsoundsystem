class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.string :url
      t.integer :score, default: 0
      t.timestamp :order, index: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
