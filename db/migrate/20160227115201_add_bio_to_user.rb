class AddBioToUser < ActiveRecord::Migration[7.0]
  def change
    # CC converting to rails 7 and mysql, removing the default
    # add_column :users, :bio, :text, default: ''
    add_column :users, :bio, :text
  end
end
