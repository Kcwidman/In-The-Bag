class AddPdgaNumToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :PDGA_num, :int
  end
end
