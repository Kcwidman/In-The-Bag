class CreateBags < ActiveRecord::Migration[6.0]
  def change
    create_table :bags do |t|

      t.timestamps
    end
  end
end
