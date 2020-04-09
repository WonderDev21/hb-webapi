class CreateTeacherPrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_programs do |t|
      t.string :name
      t.string :image_url
      t.string :resource_url

      t.timestamps
    end
  end
end
