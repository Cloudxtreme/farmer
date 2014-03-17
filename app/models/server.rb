class Server < ActiveRecord::Base

  belongs_to :category
  belongs_to :rack_mount

  has_many :vms

  def generate_index
    location = [ self.rack_mount.location.indexify ]
    racks    = [ self.rack_mount.indexify ]
    servers  = [ self.indexify ]
    vms      = []

    self.vms.each do |vm|
      vms << vm.indexify
    end

    index = servers + vms + racks + location

    index.join ','
  end

  def generate_index!
    self.search_index = self.generate_index
  end

  def indexify
    [
      self.name,
      self.domain,
      self.model,
      "#{self.ram}GB",
      "#{self.hd}GB",
      self.category.name,
      self.ip
    ].join ','
  end

  def ip_addresses
    self.ip.split( ',' ).map { |a| a.strip }.sort
  end

  def <=> b
    self.position ||= 0
    b.position ||= 0

    if self.position > b.position
      return 1
    elsif self.position < b.position
      return -1
    else
      return 0
    end
  end

end
