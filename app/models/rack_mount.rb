class RackMount < ActiveRecord::Base

  belongs_to :location

  has_many :servers

  def generate_index
    location = [ self.location.indexify ]
    racks    = [ self.indexify ]
    servers  = []
    vms      = []

    self.servers.each do |s|
      servers << s.indexify

      s.vms.each do |vm|
        vms << vm.indexify
      end

    end

    index = racks + servers + vms + location

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
