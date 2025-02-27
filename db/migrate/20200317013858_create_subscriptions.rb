class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.string :name
      t.float :amount
      t.datetime :end_date
      t.string :stripe_subscription_id

      t.timestamps
    end
  end
end
