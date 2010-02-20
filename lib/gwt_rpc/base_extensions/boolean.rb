class GwtRpc::BaseExtensions::Boolean
  def self.gwt_deserialize(reader)
    reader.read_int == 1
  end
end