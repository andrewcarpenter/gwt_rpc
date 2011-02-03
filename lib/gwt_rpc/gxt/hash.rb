class GwtRpc::Gxt::Hash < Hash
  def gwt_serialize
    ["com.extjs.gxt.ui.client.data.RpcMap/3441186752",
      self.size
    ] +
    %w(modelInstanceBelongsTo documentType searchFields recordsPerPage openForComments queryString).map {|key|
      val = self[key]
      [key, val.gwt_serialize]
    }.flatten
  end
  
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