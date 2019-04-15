class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :name
      t.string :url
      t.integer :user_id
      t.text :description
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
