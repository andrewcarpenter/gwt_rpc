class GwtRpc::Gxt::SortDir
  attr_reader :direction
  
  def initialize(direction)
    @direction = direction
  end
  
  def self.gwt_deserialize(reader)
    new(reader.read_int)
  end
  
  def eql?(o)
    o.direction == direction
  end
end