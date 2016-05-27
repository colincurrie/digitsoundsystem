class AddScoreToMixtape < ActiveRecord::Migration
  def change
    add_column :mixtapes, :score, :integer
  end
end
