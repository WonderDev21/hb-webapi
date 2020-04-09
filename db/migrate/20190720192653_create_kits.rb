class CreateKits < ActiveRecord::Migration[6.0]
  def change
    create_table :kits do |t|
      t.string :name
      t.string :image_url
      t.string :industry
      t.integer :difficulty
      t.integer :age
      t.text :description
      t.string :video_url
      t.boolean :published
      t.string :background

      t.timestamps
    end
  end
end
