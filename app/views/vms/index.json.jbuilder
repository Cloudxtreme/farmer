json.array!(@vms) do |vm|
  json.extract! vm, :id, :name, :domain, :server_id
  json.url vm_url(vm, format: :json)
end
