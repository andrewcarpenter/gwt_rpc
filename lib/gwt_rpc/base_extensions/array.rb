module GwtRpc::BaseExtensions::Array
  def gwt_deserialize(reader)
    size = reader.read_int

    obj = new
    size.times do
      obj << reader.read_object
    end

    obj
  end
end

Array.send(:extend, GwtRpc::BaseExtensions::Array)