class CreateCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :charges do |t|
      t.references :payment_profile, null: false, foreign_key: true
      t.references :chargeable, polymorphic: true
      t.string :unique_id
      t.integer :amount
      t.string :description
      t.integer :status
      t.json :external_charge_info
      
      t.timestamps
    end
  end
end
