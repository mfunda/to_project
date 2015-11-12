json.array!(@functions) do |function|
  json.extract! function, :id, :name
  json.url function_url(function, format: :json)
end
