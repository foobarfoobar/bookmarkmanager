class AddUserIdToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :user_id, :integer #add column user_id to table bookmarks
  end
end
