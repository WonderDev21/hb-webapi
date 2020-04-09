class CreateLearningPaths < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_paths do |t|
      t.string :title
      t.integer :price_in_cents
      t.string :video_intro
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end
