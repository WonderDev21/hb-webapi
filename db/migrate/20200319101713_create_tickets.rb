class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :issue_type
      t.string :contact_type
      t.string :email
      t.string :subject
      t.string :problem
      t.references :user

      t.timestamps
    end
  end
end
