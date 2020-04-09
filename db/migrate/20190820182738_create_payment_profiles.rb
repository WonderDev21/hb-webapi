class CreatePaymentProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_profiles do |t|
      t.integer :last4
      t.string :brand
      t.json :external_payment_info
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
