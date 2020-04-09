class AddCloumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :url, :string
    add_column :users, :country, :string
    add_column :users, :industry, :string
  end
end
