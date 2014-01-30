json.array!(@events) do |event|
  json.extract! event, :id, :weekday, :init_time, :final_time, :recurrent
  json.url event_url(event, format: :json)
end
