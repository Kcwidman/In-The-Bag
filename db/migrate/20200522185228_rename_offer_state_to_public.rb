class RenameOfferStateToPublic < ActiveRecord::Migration[6.0]
  def change
    rename_column :offers, :state, :public
  end
end
