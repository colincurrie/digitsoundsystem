class CreateMixtapes < ActiveRecord::Migration[7.0]
  def change
    create_table :mixtapes do |t|
      t.string :url
      t.string :title
      t.text :description
      t.string :html
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
