class Vm < ActiveRecord::Base
  
  belongs_to :server

  def generate_index
    location = [ self.server.rack_mount.location.indexify ]
    racks    = [ self.server.rack_mount.indexify ]
    servers  = [ self.server.indexify ]
    vms      = [ self.indexify ]

    index = vms + servers + racks + location

    index.join ','
  end

  def generate_index!
    self.search_index = self.generate_index
  end

  def indexify
    [
      self.name,
      self.domain,
      self.ip,
      "#{self.ram}GB",
      "#{self.hd}GB"
    ].join ','
  end

  def ip_addresses
    self.ip.split( ',' ).map { |a| a.strip }.sort
  end

end
