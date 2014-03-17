json.array!(@rack_mounts) do |rack_mount|
  json.extract! rack_mount, :id, :name
  json.url rack_mount_url(rack_mount, format: :json)
end
