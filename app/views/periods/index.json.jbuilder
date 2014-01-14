json.array!(@periods) do |period|
  json.extract! period, :id, :init_date, :final_date, :number
  json.url period_url(period, format: :json)
end
