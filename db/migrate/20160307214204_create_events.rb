class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :venue, default: ''
      t.string :description, default: ''
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :all_day
      t.integer :user_id

      t.timestamps
    end
  end
end
