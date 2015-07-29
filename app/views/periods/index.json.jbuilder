json.array!(@periods) do |period|
  json.extract! period, :id, :start_date, :end_date, :number
  json.url period_url(period, format: :json)
end
