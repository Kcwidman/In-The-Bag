class AddFlightChartIdToDiscs < ActiveRecord::Migration[6.0]
  def change
    add_column :discs, :flight_chart_id, :integer
  end
end
