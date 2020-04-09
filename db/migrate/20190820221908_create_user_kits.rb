class CreateUserKits < ActiveRecord::Migration[6.0]
  def change
    create_table :user_kits do |t|
      t.references :user, null: false, foreign_key: true
      t.references :kit, null: false, foreign_key: true
      t.integer :funding_source

      t.timestamps
    end

    add_index :user_kits, [:kit_id, :user_id], unique: true
  end
end
