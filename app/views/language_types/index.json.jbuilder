json.array!(@language_types) do |language_type|
  json.extract! language_type, :id
  json.url language_type_url(language_type, format: :json)
end
