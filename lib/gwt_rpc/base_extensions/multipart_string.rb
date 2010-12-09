class GwtRpc::BaseExtensions::MultipartString
  def self.gwt_deserialize(reader)
    size = reader.read_int
    str = ""
    size.times {str << reader.read_string }
    str
  end
end
  