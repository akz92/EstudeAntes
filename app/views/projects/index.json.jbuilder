json.array!(@projects) do |project|
  json.extract! project, :id, :date, :value, :grade, :note
  json.url project_url(project, format: :json)
end
