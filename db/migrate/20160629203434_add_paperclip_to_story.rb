class AddPaperclipToStory < ActiveRecord::Migration
  def change
    add_attachment :stories, :image
    add_column :stories, :image_position, :string
  end
end
