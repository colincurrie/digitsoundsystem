class AddScoreToMixtape < ActiveRecord::Migration
  def change
    add_column :mixtapes, :score, :integer
    remove_column :tunes, :order
  end
end
