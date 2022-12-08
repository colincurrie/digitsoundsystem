class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.string :image_url
      t.string :description
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
