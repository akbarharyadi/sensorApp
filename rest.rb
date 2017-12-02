require 'net/http'
require 'uri'
require 'json'
while true
  response = Net::HTTP.get(URI.parse("http://192.168.1.125/"))
  puts response
  # uri = URI('https://sensor-app-arduino.herokuapp.com/measurements.json')
  uri = URI('http://localhost/measurements.json')
  req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  req.body = {
    "utf8": "✓",
    "authenticity_token": "9ceISHWWr2YEqCmjCTQiNXq6QKsk/p9xfDXP2BdJ8pxcXCkCUPd4SJiClGNGg6mytbuEY92cfuDh8zQcfc8A0w==",
    "measurement": {
      "value_temp": JSON.parse(response)["temp"],
      "value_hum": JSON.parse(response)["hum"],
      "device_id": "1",
    },
    "commit": "Create Measurement",
  }.to_json
  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
    puts 'send'
  end
  sleep 2
end
