module GwtRpc::BaseExtensions::String
  def gwt_serialize(str)
    str
  end
  
  def gwt_deserialize(reader)
    reader.read_string
  end
end

String.send(:extend, GwtRpc::BaseExtensions::String)