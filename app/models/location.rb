class Location < ActiveRecord::Base

  has_many :rack_mounts

  validates :position, numericality: true

  def generate_index
    location = [ self.indexify ]
    racks    = []
    servers  = []
    vms      = []

    self.rack_mounts.each do |rm|
      racks << rm.indexify

      rm.servers.each do |s|
        servers << s.indexify

        s.vms.each do |vm|
          vms << vm.indexify
        end

      end

    end

    index = location + racks + servers + vms

    index.join ','
  end

  def generate_index!
    self.search_index = self.generate_index
  end

  def indexify
    self.name
  end

  def <=> b
    if self.position > b.position
      return 1
    elsif self.position < b.position
      return -1
    else
      return 0
    end
  end

end
