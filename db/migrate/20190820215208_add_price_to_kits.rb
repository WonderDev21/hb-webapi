class AddPriceToKits < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :price_in_cents, :integer
  end
end
