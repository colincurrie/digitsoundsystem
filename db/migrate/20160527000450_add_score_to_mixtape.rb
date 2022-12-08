class AddScoreToMixtape < ActiveRecord::Migration[7.0]
  def change
    add_column :mixtapes, :score, :integer
    remove_column :tunes, :order
  end
end
