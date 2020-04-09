class AddColumsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :city, :string
    add_column :users, :age, :integer
    add_column :users, :terms_accepted, :boolean
    add_reference :users, :language, foreign_key: true
  end
end
