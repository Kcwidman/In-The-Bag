class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.column :user_id, :integer
      t.column :conversation_id, :integer
      t.column :body, :text
      t.column :read, :boolean
      t.timestamps
    end
  end
end
