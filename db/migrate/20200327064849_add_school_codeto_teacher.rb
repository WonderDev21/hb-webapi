class AddSchoolCodetoTeacher < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :school_code, :string
    add_column :users, :school_code_verified_at, :datetime
  end
end
