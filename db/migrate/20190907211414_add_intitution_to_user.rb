class AddIntitutionToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :institution, :string
  end
end
