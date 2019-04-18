class ChangeColumnToCategoryVideos < ActiveRecord::Migration[5.2]
  def change
    add_index :categories_videos, [:category_id,:video_id], unique: true 
  end
end
