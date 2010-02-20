class GwtRpc::Gxt::Hash < Hash
  def self.gwt_deserialize(reader)
    size = reader.read_int
    
    obj = new
    size.times do
      key = reader.read_string
      value = reader.read_object
      obj[key] = value
    end
    
    obj
  end
end