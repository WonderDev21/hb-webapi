class AddRegistrationStateToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :registration_state, :string
  end
end
