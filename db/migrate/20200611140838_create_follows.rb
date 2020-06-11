class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.column :user_id, :integer
      t.column :following_id, :integer
      t.column :created_at, :timestamp
    end
  end
end
