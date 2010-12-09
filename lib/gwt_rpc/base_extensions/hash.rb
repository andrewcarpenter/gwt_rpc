module GwtRpc::BaseExtensions::Hash
  def gwt_deserialize(reader)
    size = reader.read_int
    
    obj = new
    size.times do
      key = reader.read_object
      value = reader.read_object
      obj[key] = value
    end
    
    obj
  end
end

Hash.send(:extend, GwtRpc::BaseExtensions::Hash)