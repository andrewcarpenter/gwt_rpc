class GwtRpc::Gxt::SortInfo
  attr_reader :field, :direction
  
  def initialize(field, direction)
    @direction = direction
    @field = field
  end
  
  def self.gwt_deserialize(reader)
    direction = reader.read_object
    reader.read_int
    reader.read_int
    new(nil,direction)
  end
end