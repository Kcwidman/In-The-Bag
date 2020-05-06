class CreateBags < ActiveRecord::Migration[6.0]
  def change
    create_table :bags do |t|

      t.column :name, :string
      t.column :capacity, :integer
      t.column :user_id, :integer
      t.column :created_at, :timestamp
    end
  end
end
