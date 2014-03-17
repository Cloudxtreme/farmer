json.array!(@servers) do |server|
  json.extract! server, :id, :name, :domain, :model, :ram, :hd
  json.url server_url(server, format: :json)
end
