class GwtRpc::BaseExtensions::MultipartString
  def self.gwt_deserialize(reader)
    size = reader.read_int
    a = []
    size.times {a << reader.read_string }
    a
  end
end
  