class CreateGradeLearningPaths < ActiveRecord::Migration[6.0]
  def change
    create_table :grade_learning_paths do |t|
      t.references :grade
      t.references :learning_path

      t.timestamps
    end
  end
end
