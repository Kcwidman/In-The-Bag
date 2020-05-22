class ChangeDescriptionTypeToText < ActiveRecord::Migration[6.0]
  def change
    change_column :offers, :description, :text
  end
end
