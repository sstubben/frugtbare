json.array!(@ideas) do |idea|
  json.extract! idea, :id, :description, :level_of_fun, :level_of_complexity
  json.url idea_url(idea, format: :json)
end
