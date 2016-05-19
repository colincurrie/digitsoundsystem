class CreateTargetTypes < ActiveRecord::Migration
  def change
    create_table :target_types do |t|
      t.string :name
      t.timestamps false
    end
  end
end
