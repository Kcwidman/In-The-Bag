class CreateSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :slots do |t|
      t.column :bag_id, :integer
      t.column :disc_id, :integer
      t.column :position, :integer
    end
  end
end
