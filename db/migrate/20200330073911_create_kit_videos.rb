class CreateKitVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :kit_videos do |t|
      t.string :title
      t.string :video_url
      t.integer :video_length
      t.references :kit

      t.timestamps
    end
  end
end
