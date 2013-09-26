json.array!(@events) do |event|
  json.extract! event, :name, :note, :description, :s_date, :e_date, :location, :avatar
  json.url event_url(event, format: :json)
end
