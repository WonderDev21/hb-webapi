class CreateGrades < ActiveRecord::Migration[6.0]
  def change
    create_table :grades do |t|
      t.string :title
      t.integer :grade_number

      t.timestamps
    end
  end
end
