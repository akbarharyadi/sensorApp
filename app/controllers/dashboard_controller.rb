class DashboardController < ApplicationController
  def index
  end

  def data
    dataTemp = Measurement.select('value_temp, value_hum, created_at').last.to_json
    render json: dataTemp
  end
end
