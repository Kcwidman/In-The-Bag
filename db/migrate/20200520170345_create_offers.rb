class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.column :description, :integer # this should be :text. Fixed in new migration
      t.column :state, :bool # true if the offer is standing, false if the offer is filled or removed
      t.column :disc_id, :integer
      t.column :user_id, :integer
      t.column :created_at, :timestamp
    end
  end
end
