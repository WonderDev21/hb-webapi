class CreateTeacherVoicepacks < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_voicepacks do |t|
      t.string :name
      t.string :resource_url

      t.timestamps
    end
  end
end
