class CreateDiscs < ActiveRecord::Migration[6.0]
  def change
    create_table :discs do |t|
      t.column :model, :string
      t.column :brand, :string
      t.column :color, :string
      t.column :plastic_type, :string
      t.column :weight, :integer
      t.column :condition, :integer
      t.column :speed, :integer
      t.column :glide, :integer
      t.column :turn, :integer
      t.column :fade, :integer
      t.column :description, :text
      t.column :nickname, :string
      t.column :user_id, :integer
      t.column :created_at, :timestamp
    end
  end
end
