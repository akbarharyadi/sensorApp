json.extract! measurement, :id, :value_temp, :value_hum, :device_id, :created_at, :updated_at
json.url measurement_url(measurement, format: :json)
