class RemoveCapacityFromBags < ActiveRecord::Migration[6.0]
  def change
    remove_column :bags, :capacity
  end
end
