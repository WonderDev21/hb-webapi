class AddSortNumberKitVideo < ActiveRecord::Migration[6.0]
  def change
    add_column :kit_videos, :sort_number, :integer
  end
end
