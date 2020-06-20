class CreateFlightcharts < ActiveRecord::Migration[6.0]
  def change
    create_table :flightcharts do |t|
      t.column :mold, :string
      t.column :chart_id, :string
      t.timestamps
    end
  end
end
