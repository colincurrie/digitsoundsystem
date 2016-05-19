class AddTargetToComments < ActiveRecord::Migration

  def change
    add_column :comments, :target_type, :integer
    add_column :comments, :target_id, :integer
  end

  def migrate_comments
    Comment.all.each do |c|
      c.target_id = c.story_id || c.photo_id || c.tune_id || c.mixtape_id
      c.target_type = TargetType.find_by_name('story') if c.story_id
      c.target_type = TargetType.find_by_name('photo') if c.photo_id
      c.target_type = TargetType.find_by_name('tune') if c.tune_id
      c.target_type = TargetType.find_by_name('mixtape') if c.mixtape_id
      c.save
    end
  end
end
