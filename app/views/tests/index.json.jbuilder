json.array!(@tests) do |test|
  json.extract! test, :id, :date, :value, :grade, :note
  json.url test_url(test, format: :json)
end
