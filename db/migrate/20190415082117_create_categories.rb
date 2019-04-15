class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
    create_table :categories_videos, id: false do |t|
      t.belongs_to :video, index: true
      t.belongs_to :category, index: true
    end
  end
end
