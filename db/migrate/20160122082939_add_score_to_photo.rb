class AddScoreToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :score, :integer, default: 0
  end
end
