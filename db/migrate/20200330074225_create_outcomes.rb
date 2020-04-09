class CreateOutcomes < ActiveRecord::Migration[6.0]
  def change
    create_table :outcomes do |t|
      t.string :title
      t.string :icon_url
      t.references :kit

      t.timestamps
    end
  end
end
