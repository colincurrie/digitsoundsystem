class AddPaperclipToStory < ActiveRecord::Migration[7.0]
  def change
    #add_attachment :stories, :image
    add_column :stories, :image_position, :string
  end
end
