class CreateUserLearningPaths < ActiveRecord::Migration[6.0]
  def change
    create_table :user_learning_paths do |t|
      t.references :user, null: false, foreign_key: true
      t.references :learning_path, null: false, foreign_key: true
      t.integer :funding_source

      t.timestamps
    end

    add_index :user_learning_paths, [:learning_path_id, :user_id], unique: true
  end
end
