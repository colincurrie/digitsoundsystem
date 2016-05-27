class AddScoreToMixtape < ActiveRecord::Migration
  def change
    remove_column :mixtapes, :html
    add_column :mixtapes, :score, :integer
  end
end
