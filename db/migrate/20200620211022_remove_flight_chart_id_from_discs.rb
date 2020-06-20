class RemoveFlightChartIdFromDiscs < ActiveRecord::Migration[6.0]
  def change
    remove_column :discs, :flight_chart_id
  end
end
