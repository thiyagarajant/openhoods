json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :name, :price, :status, :category_id
  json.url vehicle_url(vehicle, format: :json)
end
