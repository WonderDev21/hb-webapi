class CreateChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :chapters do |t|
      t.string :title
      t.string :video_url
      t.integer :chapter_number
      t.string :description
      t.references :learning_path

      t.timestamps
    end
  end
end
