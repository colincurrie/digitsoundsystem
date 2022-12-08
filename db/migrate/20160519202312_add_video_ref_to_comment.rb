class AddVideoRefToComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :video, index: true, foreign_key: true
  end
end
