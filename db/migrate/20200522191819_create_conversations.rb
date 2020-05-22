class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.column :sender_id, :integer
      t.column :receiver_id, :integer
      t.timestamps
    end
  end
end
