class CreateDiscs < ActiveRecord::Migration[6.0]
  def change
    create_table :discs do |t|

      t.timestamps
    end
  end
end
