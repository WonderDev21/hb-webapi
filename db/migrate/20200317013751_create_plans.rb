class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :stripe_plan_id
      t.float :amount

      t.timestamps
    end
  end
end
